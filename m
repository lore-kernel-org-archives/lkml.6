Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AAAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D77020862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1eb+9O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D77020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeICR1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:27:25 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:52659 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeICR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:27:25 -0400
Received: by mail-it0-f53.google.com with SMTP id h3-v6so1079897ita.2;
        Mon, 03 Sep 2018 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sp4cQzWbtARR6rQ1nj1SciufgTPi2e7z2a/Y3YP2ci0=;
        b=b1eb+9O0d4u78doUDkVAFaTT+SflO7fhFNCb4tP93pRfrloaieuxKf9pte9hyzyp5G
         /o/11FIsbSgTaVoY00OnZk7O8iAFQaxtXQZOsYSSlrv9Ec9z2IB/qEXmdEwgLqgvc2iN
         KelU6m2wgwIiz4bmlfsjch/ubSjY1Es0VpGPsLZEPAHUvvAHCubV1o6fC9LTK4SWWSLU
         IZ3kP96ZgJt+ykvAATTBRpKSbPuwvPdBj1nygnCprl/DJuh/8LEbStKr5IIiae6+KZUK
         armMrEYGjkp56wfIEB2D9+uXBLpNoPsF6fZ9dJIr8jUW5LMi7o4npZctSGzkRtHNVpXl
         y/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sp4cQzWbtARR6rQ1nj1SciufgTPi2e7z2a/Y3YP2ci0=;
        b=nCBTUzricadWHfsOXuzV43Ylu3WXfYSNODTi13QnZfjTRDvhyyKUS3wMGW/vsInGvZ
         wpg8epawm4q2y4JKYjl4eg+Gq1/dULyQhWhcR1DLKQ1dUuvYMChw0DlQS359wIzJT6Lx
         cqY2fgQO9qZsyabWyoDOKfjbgqIHB0Smh1yskU5uk/Dla7uQMmSFSFcSv+bh5OFSTPPZ
         kq1JxF1gkTAwaf7JcxzMmDkE7IgZ+YItW5qBS5A+8Y64m9MwM/ZuxmRdbUg82RF+JKDS
         NTUJoRnW87xIvOarq8B6cuqDNjFh6tUO5g+pS2HFkv3IZO2PyBe8JTMvYZPYAl/pf7OC
         A2CA==
X-Gm-Message-State: APzg51Do/ObciFMiQlq2mhwDh9mbPIKjC52nPOk9YTvRvOuKNVJ8VbO+
        WQyor3E2kHnebm+5+Di7FEsNKoD3U0WHfRzpBGlWBg==
X-Google-Smtp-Source: ANB0Vda4plP0FbAYVFQoTZFUFgrOE8F2MikKgp+WQuZelkugRcJ4dN+F1tBaegf8W8jlIneohHONXRmC5iD6eIEm22k=
X-Received: by 2002:a24:1d84:: with SMTP id 126-v6mr4792349itj.63.1535980039955;
 Mon, 03 Sep 2018 06:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180901083834.11201-1-kristian.evensen@gmail.com> <87ftyqwx2e.fsf@codeaurora.org>
In-Reply-To: <87ftyqwx2e.fsf@codeaurora.org>
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Mon, 3 Sep 2018 15:07:08 +0200
Message-ID: <CAKfDRXjry4D2Av-iZ+4ufOoF=nbdGCtZ0scigj6ZqPHAYba8zA@mail.gmail.com>
Subject: Re: [PATCH v2] mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 3, 2018 at 3:05 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> The changelog should be here, after the '---' line, so that git can
> automatically drop it. But I can fix it before I commit, but in the
> future please add it to the correct place.

Thanks for letting me know and thanks for fixing my error this time. I
was not aware of this requirement, but will remember about it in the
future.

BR,
Kristian
