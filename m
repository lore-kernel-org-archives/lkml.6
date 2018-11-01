Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B5AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000512081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nnc4iR5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000512081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeKAW5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:57:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33472 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbeKAW5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:57:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id z72-v6so3642869ywa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETzPVJMUPu1nPGTn1124ZvpKmzdt7HVej18GLODBnkw=;
        b=Nnc4iR5pKzPoEspUSoX8zD14K4ug/qAW9FYMwtcleLvPFaXAQjkE9IRH1YXUgk9Flx
         OFqX4fzItAIM03BqYcZ5Wruzl4CY7fL8pnqVpU5uHySM85Iv0Mqg00lP22pnugdlwXiQ
         xyBCbdZNjqH2fGiqxTE1CK4RtaT97vcLvknwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETzPVJMUPu1nPGTn1124ZvpKmzdt7HVej18GLODBnkw=;
        b=aaL/phcAV2wFGFw5KYMW3QsVPvthZZYMK9FyJTHJkgfSh+MYi4Vr+pIVe0eyMVo/XC
         aUKe5XXcg0iZ6j3iMvICXLCnlA9hyRXgf9E0oJsz9b9QaKnGQgp7shg6pEcyFsicN7Bf
         GeMdNAmG9Ooe9AnHj6yQxT99Xk2RZThX49tAhE4axNF9/zHdHkVyNygNdbnKWb3gZVYr
         Ee5uDboHb/VTQmqul+zHbjlQTb0UskPiF+7hS3aI2g5HDQxvmTCrYZ2r3JlTMOJVn7RJ
         4kwbbZw1lXKSviZWWFex/R3i5DVnX+oC8tmnB9SM6W5dE9zX1cRcOFLp7/IADAIVNQSP
         C5nQ==
X-Gm-Message-State: AGRZ1gKnu/ktML9yTKl125qbfHH7JsptHlT/W0fQSnA9q75MSny5vqQW
        rlXn8UNJlbuV7HMJwkw7Qkdog7jYQ9w=
X-Google-Smtp-Source: AJdET5fA9+G7XbSzp6GVHdhKxMnrnGscDsM6XB0hZ6Qnmc5tvNKhikXkFriNr+63CrWdoP3eRfz7ag==
X-Received: by 2002:a0d:ec55:: with SMTP id v82-v6mr7424882ywe.384.1541080447338;
        Thu, 01 Nov 2018 06:54:07 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id 207-v6sm9012798yww.21.2018.11.01.06.54.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:54:05 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id f192-v6so244843ywh.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:54:05 -0700 (PDT)
X-Received: by 2002:a0d:fd82:: with SMTP id n124-v6mr784510ywf.443.1541080445030;
 Thu, 01 Nov 2018 06:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <1540971728-26789-1-git-send-email-mgottam@codeaurora.org>
 <3ff2c3dd-434d-960b-6806-f4bb8ec0d954@linaro.org> <3364115421e89c7710725c06b820f8c6@codeaurora.org>
In-Reply-To: <3364115421e89c7710725c06b820f8c6@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 1 Nov 2018 22:53:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A+9GWmn4aD4D2JMf1e1m-6Dtc3xUdMZsf8fPtgi34QVQ@mail.gmail.com>
Message-ID: <CAAFQd5A+9GWmn4aD4D2JMf1e1m-6Dtc3xUdMZsf8fPtgi34QVQ@mail.gmail.com>
Subject: Re: [PATCH] media: venus: dynamic handling of bitrate
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:01 PM <mgottam@codeaurora.org> wrote:
>
> On 2018-11-01 17:48, Stanimir Varbanov wrote:
> > Hi Malathi,
> >
> > Thanks for the patch!
> >
> > On 10/31/18 9:42 AM, Malathi Gottam wrote:
> >> Any request for a change in bitrate after both planes
> >> are streamed on is handled by setting the target bitrate
> >> property to hardware.
> >>
> >> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/venc_ctrls.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> index 45910172..54f310c 100644
> >> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >> @@ -79,7 +79,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>  {
> >>      struct venus_inst *inst = ctrl_to_inst(ctrl);
> >>      struct venc_controls *ctr = &inst->controls.enc;
> >> +    struct hfi_bitrate brate;
> >>      u32 bframes;
> >> +    u32 ptype;
> >>      int ret;
> >>
> >>      switch (ctrl->id) {
> >> @@ -88,6 +90,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>              break;
> >>      case V4L2_CID_MPEG_VIDEO_BITRATE:
> >>              ctr->bitrate = ctrl->val;
> >> +            if (inst->streamon_out && inst->streamon_cap) {
> >
> > Hmm, hfi_session_set_property already checks the instance state so I
> > don't think those checks are needed. Another thing is that we need to
> > take the instance mutex to check the instance state.
>
> Yes Stan, "hfi_session_set_property" this property check the instance
> state,
> but returns EINVAL if this is set at UNINIT instance state.
>
> Controls initialization happens much earlier than session init and
> instance init.
> So the instance is still in UNINIT state which causes failure while
> setting.
>
> Through this patch we try to meet the client request of changing bitrate
> only
> when both planes are streamed on.

Where does this requirement come from? It should be possible to set
the control at any time and it should apply to any encoding happening
after the control is set.

Best regards,
Tomasz
