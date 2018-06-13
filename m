Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B01F9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F9F208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YSLxmO1b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PElfmOpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F9F208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964845AbeFMVJ6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:09:58 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40413 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964828AbeFMVJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:09:54 -0400
Received: by mail-vk0-f67.google.com with SMTP id o71-v6so2400350vke.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9ldRJ8sRd73u+QInRbQ/mMV8cTDVP9jju/8yssxbQvE=;
        b=YSLxmO1bFn1zTiH4tCrOLvq2zPTyO+pL8cKRmzONAABK5FHFyAMpXMGNU1j9DQOdu7
         yR2cHsWR138VanlSgLtnQi3i4Mnm8s9X3jxvDLF4yfcYtVSm/uUp1uukViRtM6gwUu/8
         fxtjKscd05NxJ9PkqYUs3G4/dapfJ+0Le1h09lk6i/+ER7cDAJSDpr01FEobrWF+9G7D
         KTdpOjEShhj17OOm+hAL5tMiIhWgdCUdQZLC8wjMCfa2Id2Pn2yURuWRO6C/01dR8iEO
         LSl7DJUhMPDoLwXPSKrbYhrZrU6UAXNuaV+ZmKaqRL0ADMgBzhuv4kwVY8q8MyFrFvs9
         UHRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9ldRJ8sRd73u+QInRbQ/mMV8cTDVP9jju/8yssxbQvE=;
        b=PElfmOpBGqW7s05h1LKULDP7HoSP1MkWdFNSyuXQ/B5imKRfn++r6MbbJJiYaflK/c
         QMGzfVp0623Oo2WnLtNpb8Hqm08t2Cuy285Hi4NGcD1OTiDClp5oDEI/IKoHP6g2nbWl
         TUK5BS8l+e7x2JCJJBKdtnJVvrPgvpiHPv84k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9ldRJ8sRd73u+QInRbQ/mMV8cTDVP9jju/8yssxbQvE=;
        b=OgLvhG4ShtY/fgMXD1BDYJY61TFg72prM+mTpfFY57mLoMfKkiagmInQHJnsdRsREP
         riKN0XmlxsglUOIt1q4jxdKlfrUGdLQ2+cW0VfNhfQev8u+t9WXlLL50fFQLFTd2AsBV
         Jlso4MzqwcdM6VvgU52OA8hjzVdoMdQdrNXgED1BhrxJgqF4BPO/2lb0QLyk+Hk7Msid
         nZrx0kfntr56ylF2vgwdTnsK6zgK9W/cnEx+Z+bqdH9tS8hGMfcZZX2BTL8aM0DO+8YI
         nDxA2hw07nveBY3xflMjXY17aqt6/155jdjaqcsobfglrumvRz5ZlEjC2CaUpaMef7kg
         16Cw==
X-Gm-Message-State: APt69E01jwVwqIhrVfEwW56BzLaoHS086T6rvzFiJYUFTS6XWBG6fVD0
        /9yWRXNlp9gqDw7baj6TVKA6MPzrJihx8NJbVZlQAQ==
X-Google-Smtp-Source: ADUXVKLWxjyyAutCGfoTQuAHoHA549lAlW9uHKhJboOzCR8IIvd7hvyMhhwgy6/mdZL1d96DLRzoImeuTQqYo2fb5QI=
X-Received: by 2002:a1f:7c4:: with SMTP id 187-v6mr4058280vkh.60.1528924193311;
 Wed, 13 Jun 2018 14:09:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 14:09:52
 -0700 (PDT)
In-Reply-To: <1528737949-17495-11-git-send-email-rplsssn@codeaurora.org>
References: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org> <1528737949-17495-11-git-send-email-rplsssn@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Jun 2018 14:09:52 -0700
X-Google-Sender-Auth: Bc9CoCMPZOpVwBpP08LeDw_FUwU
Message-ID: <CAD=FV=Vc_wtLTxM8A9T-RZ8h5XpkSLLUVJzmCQSytXFwOPRkOw@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] drivers: qcom: rpmh-rsc: allow active requests
 from wake TCS
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 11, 2018 at 10:25 AM, Raju P L S S S N
<rplsssn@codeaurora.org> wrote:
> @@ -148,7 +148,8 @@ int rpmh_rsc_invalidate(struct rsc_drv *drv)
>  static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>                                          const struct tcs_request *msg)
>  {
> -       int type;
> +       int type, ret;
> +       struct tcs_group *tcs;
>
>         switch (msg->state) {
>         case RPMH_ACTIVE_ONLY_STATE:
> @@ -164,7 +165,25 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       return get_tcs_of_type(drv, type);
> +       /*
> +        * If we are making an active request on a RSC that does not have a
> +        * dedicated TCS for active state use, then re-purpose a wake TCS to
> +        * send active votes.
> +        * NOTE: The driver must be aware that this RSC does not have a
> +        * dedicated AMC, and therefore would invalidate the sleep and wake
> +        * TCSes before making an active state request.
> +        */
> +       tcs = get_tcs_of_type(drv, type);
> +       if (msg->state == RPMH_ACTIVE_ONLY_STATE && IS_ERR(tcs)) {
> +               tcs = get_tcs_of_type(drv, WAKE_TCS);
> +               if (!IS_ERR(tcs)) {
> +                       ret = rpmh_rsc_invalidate(drv);
> +                       if (ret)
> +                               return ERR_PTR(ret);

In v9 you looped as long as the "ret" was -EAGAIN.  Now you're not.
Are all the callers setup to handle -EAGAIN or should you keep the
loop in for -EAGAIN?  I don't think callers handle this well.

...or is there some reason that EAGAIN can't happen in this call to
rpmh_rsc_invalidate()?


-Doug
