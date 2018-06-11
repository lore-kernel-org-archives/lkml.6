Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fFgKCGYaHlv7FQAAmS7hNA
	; Mon, 11 Jun 2018 06:44:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0415D60791; Mon, 11 Jun 2018 06:44:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pM0yPjzM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 464A660385;
	Mon, 11 Jun 2018 06:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 464A660385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeFKGov (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:44:51 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32789 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753974AbeFKGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:44:49 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so22531209otj.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f4M0FLNVufLrdGtWIUpwtSLtXHOJMDav2ToJb5TNqAo=;
        b=pM0yPjzMXoBcgez+UHL1v47B+t0H2XIlH3FSJp/8U975TrnaKU569m0jilXbcT3rFt
         jpJ2e3xdyQL99qhWktPfOQBaaJGGNJhQ99p4uKVUKbWWA6+oOk5UQgNebaLtLjY0o4NF
         QNCl3xhp2OC/3eA+jcKwjTom49MRzSrcL8qFyxVhFCcu1s3dZFgXL61+6Et1wV6CrtwR
         KNRCMAxciS+v2S4XFX7ZTFjtxxd8f27ftIirIZzWQOZoT9kC8Q0phDtZK8aKBMRDRa+T
         iqZKYR6rXOkHk9iAltm9536RvPYXotrDKgg7Ei3P72zC/2rYlCeH/jDI5Mca3X09EmSJ
         nISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f4M0FLNVufLrdGtWIUpwtSLtXHOJMDav2ToJb5TNqAo=;
        b=LAbMDAdQir6+9Uu4n2E+LLB0Vyj4uV8WD2FVgXI7fXiHJnca00frG9/unQEhm0oBUd
         DlpcJAK+nH0x32uRliBXNX39xa04NI5l8i9AMfbDMI9kaFyYTqT0cBXMoJUhFx2iIpCS
         sXdw9jG4tW2MUAWTRgpQnJp5yJ1SH+IUlp2am4yUzrlDid88stFuID/9lX+T3/2RvkTv
         NDVEssEJ+L+8ptax0IPhkt1Sh20EtlH4GaUYF6XqRo/9nkRNWt+i5UsK1N95HZQ3EfbM
         4EICXZDem44KqPD6YX4PkzvM4HGYAFJG9YqCpEDJqzS2oAURtHaeKbjOjdC7NLAPwthe
         UmIw==
X-Gm-Message-State: APt69E2VXaeE4dXi+aJ0zG2Qnbd1d4WPOmrtlTi7gVnfqgtIxf72ujXS
        Y8Q2l6Eicmd1R1oApvchp1IIeH3k3+eRee2W5TIVjw==
X-Google-Smtp-Source: ADUXVKJByRjayI6tgREmD4J36Q+zdXAExLyk3PizsYWK+isxhKesmohc0jqJi6KVGELDQcCoyaCCpjOl8ViJ+plBDKE=
X-Received: by 2002:a9d:3cda:: with SMTP id t26-v6mr9668011otf.309.1528699488968;
 Sun, 10 Jun 2018 23:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180530071613.125768-1-keiichiw@chromium.org>
 <20180530071613.125768-2-keiichiw@chromium.org> <a16dca32-4198-72c1-cf22-83f18a8cfcb6@xs4all.nl>
 <bd56e330-91d2-dfde-4cfb-40b466953dad@linaro.org> <CAKQmDh8MnArB1jCD6STh9FgLX+H4ZsEnH+coOJe-4A=FNPGshA@mail.gmail.com>
In-Reply-To: <CAKQmDh8MnArB1jCD6STh9FgLX+H4ZsEnH+coOJe-4A=FNPGshA@mail.gmail.com>
From: Keiichi Watanabe <keiichiw@google.com>
Date: Mon, 11 Jun 2018 15:44:37 +0900
Message-ID: <CANb2CJFXhY+mzEV7AnM5EQcvqyeAH7G=t3Bi_9_d9_+_Kce9RQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: v4l2-ctrl: Add control for VP9 profile
To: nicolas@ndufresne.ca
Cc: stanimir.varbanov@linaro.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        matthias.bgg@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        tom.saeger@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hans.
Thank you for the review.
Your idea sounds good.

However, I think that changing V4L2_CID_MPEG_VIDEO_VPX_PROFILE to an enum
breaks both of s5p-mfc and venus drivers.  This is because they call
'v4l2_ctrl_new_std' for it.  For menu controls,
'v4l2_ctrl_new_std_menu' must be used.

https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/s5p-m=
fc/s5p_mfc_enc.c#L2678
https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/qcom/=
venus/vdec_ctrls.c#L133

I can fix them within the commit for adding VP8_PROFILE control, but
cannot confirm that it works on real devices since I don't have them.
What should I do?

Best regards,
Keiichi
On Fri, Jun 8, 2018 at 10:00 PM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
>
>
> Le ven. 8 juin 2018 08:56, Stanimir Varbanov <stanimir.varbanov@linaro.or=
g> a =C3=A9crit :
>>
>> Hi Hans,
>>
>> On 06/08/2018 12:29 PM, Hans Verkuil wrote:
>> > On 05/30/2018 09:16 AM, Keiichi Watanabe wrote:
>> >> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for selecting desir=
ed
>> >> profile for VP9 encoder and querying for supported profiles by VP9 en=
coder
>> >> or decoder.
>> >>
>> >> An existing control V4L2_CID_MPEG_VIDEO_VPX_PROFILE cannot be
>> >> used for querying since it is not a menu control but an integer
>> >> control, which cannot return an arbitrary set of supported profiles.
>> >>
>> >> The new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE is a menu control as
>> >> with controls for other codec profiles. (e.g. H264)
>> >
>> > Please ignore my reply to patch 2/2. I looked at this a bit more and w=
hat you
>> > should do is to change the type of V4L2_CID_MPEG_VIDEO_VPX_PROFILE to =
enum.
>> >
>> > All other codec profile controls are all enums, so the fact that VPX_P=
ROFILE
>> > isn't is a bug. Changing the type should not cause any problems since =
the same
>> > control value is used when you set the control.
>> >
>> > Sylwester: I see that s5p-mfc uses this control, but it is explicitly =
added
>> > as an integer type control, so the s5p-mfc driver should not be affect=
ed by
>> > changing the type of this control.
>> >
>> > Stanimir: this will slightly change the venus driver, but since it is =
a very
>> > recent driver I think we can get away with changing the core type of t=
he
>> > VPX_PROFILE control. I think that's better than ending up with two con=
trols
>> > that do the same thing.
>>
>> I agree. Actually the changes shouldn't be so much in venus driver.
>
>
> Also fine on userspace side, since profiles enumeration isn't implemented=
 yet in FFMPEG, GStreamer, Chrome
>
>
>>
>> --
>> regards,
>> Stan
