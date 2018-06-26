Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4243C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB4326CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tIliX7xe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PQhzTSVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB4326CB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeFZPAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:00:36 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34799 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeFZPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:00:32 -0400
Received: by mail-vk0-f65.google.com with SMTP id q135-v6so10229547vkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8VWG8ND0Y6qAVmL34KXuajFXUm8NNrKQbdxw6E5XBPE=;
        b=tIliX7xe+wh0XJiY6u3CTNVq6omaw4sSFGe8JqH1kZaJ3Po6ayvzmPICW3iuVC9cSz
         E8lAoWihDqX+cz827aWRpU77R3QbRB4HsX9rsg4SQlONxoMEpmFWH4gxcsDlm+EE0Trl
         OwWImfwvqdf/YNFNNUc/Isi1gGQRaY/uicUw5Bjj9pb/jJXa2tfS2YwHV1cBtdVJukvn
         vGX52fDcNH09YN0KjiPGU3g79FRo97v8HDpu8oDg1PuI8DPpuSm7VSqPpADw81hTZk/Q
         aN++TXoFl9i3WN1qI/xiUyBK5sbJmRWiNT+g/M20ylDie4kMX/j0p/aZMc4C9TFY2m0Q
         IX7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8VWG8ND0Y6qAVmL34KXuajFXUm8NNrKQbdxw6E5XBPE=;
        b=PQhzTSVozzT/uO/SvzMZBDx+Lsw9S8+zzjaEfsoUEj5shCVibcrJYZopwWptnQPyp/
         ZG32BISEPy0jjyZTee/tKPm7GKbRfcUqqof6q+h/zmLru22dxTqTxHCVzISSViWqiuaX
         tSRuZ+K8axRFhkKsM70phqvGZ1LEc+5/ImltQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8VWG8ND0Y6qAVmL34KXuajFXUm8NNrKQbdxw6E5XBPE=;
        b=TfxzHzcgVwh2As3QycfuvyGxJHejLAHo4G3ljnShbWoeDFNPAteYCP3rvyQd5Tj4Uc
         FgFM/T2cfhjTIUtn54xZu8uwjmA10Wc4NbYZYgwbHbLvGUZvRnULAvuN7UJl3T5koRHM
         /5sdbWDKqbbDpS/tdcFElQumaPwcQ6GrKvFkNHd3yW0T6vMU1M23/qvXcQOLn80rwuVB
         jf+7Iq9hh+uBTwYuylVm/OSZzp+HHCc76DMLKPKC+ztII6MEdjqLCwp8R+xSyrS69TnJ
         Nf29e43K7dlZNvCryTQfeL5yAKcjT2+nIUnKn0uA4TvDHrAF0VJsvJwaPGmAVat1dB6n
         93Ow==
X-Gm-Message-State: APt69E3TxSAizJb2yGRNe7YrOhbisqTsPZrWDW6ETO4cavqwhzgWJWIP
        C5Od/mBCOBLSHU2nVCXZgHRE0OeVFvj6C8EYxvR+sQ==
X-Google-Smtp-Source: AAOMgpe7Ux+Jj39ARK4U7SufmvWilrEDJQ3aXkVXw07tc51W45qe1oYO/UNSIoMiJj+wGaCQfwjzl8ypUB2eTsz94ZA=
X-Received: by 2002:a1f:2758:: with SMTP id n85-v6mr1160687vkn.117.1530025229893;
 Tue, 26 Jun 2018 08:00:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 08:00:29
 -0700 (PDT)
In-Reply-To: <20180626120733.GD1779@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org> <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com> <20180626120733.GD1779@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Jun 2018 08:00:29 -0700
X-Google-Sender-Auth: xs74OPy14WLhqZdzwZ1OmzIh5ng
Message-ID: <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 26, 2018 at 5:07 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 25, 2018 at 11:50:52AM -0700, Doug Anderson wrote:
>
>> ...to this patch.  Speaking of which it might be getting very close to
>> time for this series to land along with David's other series, AKA:
>
>> * [1/2] regulator: of: add property for allowed modes specification
>>   https://patchwork.kernel.org/patch/10395731/
>
>> * [2/2] regulator: of: add support for allowed modes configuration
>>   https://patchwork.kernel.org/patch/10395725/
>
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Sorry, wasn't suggesting making any changes to those two patches, just
was noting the dependency.  ...but, as you said, the two dependent
patches have already landed and I just didn't notice.  :(  Sorry for
the noise.

-Doug
