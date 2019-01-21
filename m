Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0774C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6534520663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWsnzBdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfAURNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:13:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38661 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAURNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:13:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so11624002wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YOsOowzINI371zCyHfth4PAfwLOH7XtK+SqK8pSvud8=;
        b=CWsnzBdCwsoZEsywXsspfMPDi4k6AdkMt1xb3Dmbk0fcHXsc2XySzfgpoEyH/9364a
         2RPR6mx1cT+kbCS20NUQQuw5/2CFJff42NvU+i/gW9ql7UvdyJmejkrbRRrMEM75wf6Z
         O4x4wsuJx0Yqo6sokuMs31emuQdXUEuE+yxdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOsOowzINI371zCyHfth4PAfwLOH7XtK+SqK8pSvud8=;
        b=b0RiOggpf+977oOV1VL0mO46iSPOlofz17hUrYgmUZN5O1e/w/u7JH6WLqMG0Q7zaH
         dTeP4/DHUZFyXh6XXNenc106+0DJRY2sUKN8VchSt16wE7WPJnkddjjLokm5fgHYXTxa
         Q6zQEeUzbYHhmJRU1I7j1JrNK1uu2MemYw6g2QjkK44mKUTEOAoD4O2jmy8noVN7s5a7
         gR2ppLiaJ6/BKFsOEPDLr3fWNNyN+Sk6b1iQjJdrQMxUL/D0EI19dYC6w8yJJwfY7Bet
         G8zF4VoSbP23HJFaSmAJ11w69qyvAIMkOE7O3EEyBwzprpA/n/FUZhdiK4IsHbhFmQBi
         XTLw==
X-Gm-Message-State: AJcUukdPW1xdGrb84/5WYNS+M/y/nSe0FEGvzhs8vMrMhU2fwqI7KcaB
        I6dP0ORkwOI4T2PDbHQ2g31RvA==
X-Google-Smtp-Source: ALg8bN4I5tm40AdKalnqmiH6e+8e762l2x/K14zlj34aXZ8slZwTChhfLjuWowsNEpwFBJxGoT+rVA==
X-Received: by 2002:a1c:1383:: with SMTP id 125mr248998wmt.71.1548090797328;
        Mon, 21 Jan 2019 09:13:17 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h62sm39941937wmf.11.2019.01.21.09.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 09:13:16 -0800 (PST)
Subject: Re: [PATCH v3 1/3] drm/msm/a6xx: Add support for an interconnect path
To:     Rob Clark <robdclark@gmail.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
References: <20181220173026.3857-1-jcrouse@codeaurora.org>
 <20181220173026.3857-2-jcrouse@codeaurora.org>
 <CAD=FV=WjLB8TV80cMef9ZqYn7h3szJ6x67_6pL9FnM1Q+8i_2A@mail.gmail.com>
 <CAF6AEGtjHWTSSaeMuGsL7+2bSsBBHWV3TVf8m2ru40d+wKeeMA@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <0a260759-be37-bf8f-6e1b-b24406c8eeca@linaro.org>
Date:   Mon, 21 Jan 2019 19:13:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAF6AEGtjHWTSSaeMuGsL7+2bSsBBHWV3TVf8m2ru40d+wKeeMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 1/18/19 21:16, Rob Clark wrote:
> On Fri, Jan 18, 2019 at 1:06 PM Doug Anderson <dianders@chromium.org> wrote:
>>
>> Hi,
>>
>> On Thu, Dec 20, 2018 at 9:30 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>>>
>>> Try to get the interconnect path for the GPU and vote for the maximum
>>> bandwidth to support all frequencies. This is needed for performance.
>>> Later we will want to scale the bandwidth based on the frequency to
>>> also optimize for power but that will require some device tree
>>> infrastructure that does not yet exist.
>>>
>>> v5: Remove hardcoded interconnect name and just use the default
>>
>> nit: ${SUBJECT} says v3, but this is v5.
>>
>> I'll put in my usual plug for considering "patman" to help post
>> patches.  Even though it lives in the u-boot git repo it's still a gem
>> for kernel work.
>> <http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README>
>>
>>
>>> @@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>>>                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>>>
>>>         gmu->freq = gmu->gpu_freqs[index];
>>> +
>>> +       /*
>>> +        * Eventually we will want to scale the path vote with the frequency but
>>> +        * for now leave it at max so that the performance is nominal.
>>> +        */
>>> +       icc_set(gpu->icc_path, 0, MBps_to_icc(7216));
>>
>> You'll need to change icc_set() here to icc_set_bw() to match v13, AKA:
>>
>> - https://patchwork.kernel.org/patch/10766335/
>> - https://lkml.kernel.org/r/20190116161103.6937-2-georgi.djakov@linaro.org
>>
>>
>>> @@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>>>         if (ret)
>>>                 goto out;
>>>
>>> +       /* Set the bus quota to a reasonable value for boot */
>>> +       icc_set(gpu->icc_path, 0, MBps_to_icc(3072));
>>
>> This will also need to change to icc_set_bw()
>>
>>
>>> @@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>>>         /* Tell RPMh to power off the GPU */
>>>         a6xx_rpmh_stop(gmu);
>>>
>>> +       /* Remove the bus vote */
>>> +       icc_set(gpu->icc_path, 0, 0);
>>
>> This will also need to change to icc_set_bw()
>>
>>
>> I have the same questions for this series that I had in response to
>> the email ("[v5 2/3] drm/msm/dpu: Integrate interconnect API in MDSS")
>> <https://lkml.kernel.org/r/CAD=FV=XUeMTGH+CDwGs3PfK4igdQrCbwucw7_2ViBc4i7grvxg@mail.gmail.com>
>>
>>
>> Copy / pasting here (with minor name changes) so folks don't have to
>> follow links / search email.
>>
>> ==
>>
>> I'm curious what the plan is for landing this series.   Rob / Gerogi:
>> do you have any preference?  Options I'd imagine:
>>
>> A) Wait until interconnect lands (in 5.1?) and land this through
>> msm-next in the version after (5.2?)
>>
>> B) Georgi provides an immutable branch for interconnect when his lands
>> (assuming he's landing via pull request) and that gets pulled into the
>> the relevant drm tree.
>>
>> C) Rob Acks this series and indicates that it should go in through
>> Gerogi's tree (probably only works if Georgi plans to send a pull
>> request).  If we're going this route then (IIUC) we'd want to land
>> this in Gerogi's tree sooner rather than later so it can get some bake
>> time?  NOTE: as per my prior reply, I believe Rob has already Acked
>> this patch.
>>
> 
> I'm ok to ack and have it land via Georgi's tree, if Georgi wants to
> do that.  Or otherwise, I could maybe coordinate w/ airlied to send a
> 2nd late msm-next pr including the gpu and display interconnect
> patches.

I'm fine either way. But it would be nice if both patches (this one and
the dt-bindings go together. The v6 of this patch applies cleanly to my
tree, but the next one (2/3) with the dt-bindings doesn't.

Thanks,
Georgi
