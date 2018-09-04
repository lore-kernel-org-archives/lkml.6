Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E9C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174012075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLJfQxKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174012075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeIDJ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:57:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45950 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeIDJ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:57:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so4418595oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 22:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NCzxBo662TQvVPxTYYf/g4WjHqOp1yX9+owDn7kdteY=;
        b=LLJfQxKrg5Icjg1LzAY1pbRP6lo+5WPdKuuhdR3xXourA3rXE9K6w3g/4ZdFAWMayc
         yIEoWxx5gWmdzh7lDKSl3EIfRuJHlBFA9sYKGePHKsiEtb/TRzIqL41IU6vRXNUiOcZS
         21LRsosYTr06BKbBjW9O2FHw7p/CvFusnWRQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NCzxBo662TQvVPxTYYf/g4WjHqOp1yX9+owDn7kdteY=;
        b=ZxRnuv2YxaS/zPsnZ1jToAyoZCSLwBIEDU1sqLcLST3LiNsABmNtvtS4mqLqz4zeUO
         WciGKOfm/AR3+dKGmiGtNS/Xc62OKs8k/szifmW0dzqKnumWVIkBGLr6pz24Y7dMj6zD
         61ucqkrkXdjp6RkPWK9dBZ6SZ4hT+EkRoaQ8dQFV08dBIOp6fVg7pvSFkffqIkavAssp
         FXopFahl2xMoivJ8ZuKkndQ9yT5Z9FttbEwoxT6UbMgBLU/718oF8QbXJ9Mt0/TEOIL9
         ptSa3IKr+cPmz3PF/EHvCw6DcHs+nLkE21PKyoteCP9cfJYbKhD0CCZ5qYoLWdza0TJn
         DKrQ==
X-Gm-Message-State: APzg51DYs7lOgHn2962Ahyj3eKh/BzpYTpKE05w03SjaYNswPd8Iwobd
        xQ/0KsTz8nnnTTJrM6DsteyuoJw3cS6M00ABni4n/g==
X-Google-Smtp-Source: ANB0VdaZpkhXQ2z/hGpfsLjp66ermh2FGWkeLHF8Fd/DPofBpCxpZ31BUMesRrmxoPkDBe9SBm0Hyae9M1ChRkSPAI4=
X-Received: by 2002:aca:be56:: with SMTP id o83-v6mr23701098oif.301.1536039267730;
 Mon, 03 Sep 2018 22:34:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1d28:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 22:34:27 -0700 (PDT)
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 4 Sep 2018 13:34:27 +0800
Message-ID: <CAMz4ku+0e5-hfzZ2wKn3KCvAvPAE8tB=pzcf59Vg7DJ+42C_6w@mail.gmail.com>
Subject: Re: [PATCH 1/5] serial: sprd: Remove unused structure
To:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11 August 2018 at 09:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> Remove the unused reg_backup structure.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Do you have any comments for this patch set? Thanks.

-- 
Baolin Wang
Best Regards
