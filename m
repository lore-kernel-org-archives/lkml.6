Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DFECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBB2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umvk3dYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFBB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJSXhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:37:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39323 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeJSXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:37:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so37874766wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFFqgeamZ3c8VrHtxsPbFzSqJgGZR+RfMEy5QmGcCUc=;
        b=Umvk3dYf70+85UyR2F/S8kU3YkdS0zoc5n3EOVfSSO/TItiY1GoK2nzPO4S+zSzC8N
         aS/G4oj+xMqpuEBg4ui/5Yjk0YHBzqs4WXujDL5bZpAzSp3jI5mCcug9TsUF6R81koY+
         qQ0eFzRC/FgW0gm6hKvXDUQUDgpaeDV6ek+FfwPJqM0Cub2iABmp2DX9VYtxGc+DnWJJ
         vkjFnKmoKxeyRFRzVPpO49qLFR0Fz4vVUEMgJwlqLm3IyCRwGsZOEJZEiESGXdKssC98
         AcI9duTt7CqmhhSiNJZOB5Gye06D708hnSkuIjYuI4PXWCh1K52mmwxD7lfmdOh0SUDS
         MFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFFqgeamZ3c8VrHtxsPbFzSqJgGZR+RfMEy5QmGcCUc=;
        b=aJ5qep+0Wusf2hC8VI7XvTY4eUINR9vUDrhJxhELOiva8MGYTTFlIy4amFi8lCEb/5
         bxlUHA/GAywqq0lHSrl7h6rC9cuJVTxIKts8gsKd5pXrw3SlPYBpzHXd2AEpnshs9a0W
         pKvrw3fWNubsa4Q4Mxd09+ZJPt5Icdx4aLsZc3A9wGRoMD5j/6AoWl5Sk51l767NvcbK
         N7E3OfbMM/isESgsvIgh5TARiCjg4CXNsNW8DtDwtnDonrY5ka4640ukcXo6qJkuA3VD
         w5HAqkaccHWs7j8OwT1VtGyJMEgzP8XZPT8at7pXQE0I96Bx9N+UwbOjbvCAH22pbzvR
         kFew==
X-Gm-Message-State: ABuFfojk2AEJ22+nf+jIkot5CJ9oeLc2zFqOlTLiDfCXUpVsxEWniklX
        rwXNu9vvFQV+AQ7fZv7Www7MSIZNunUZ7qT/AiIqkw==
X-Google-Smtp-Source: ACcGV61JLM3CYBnNrFP2GZ3NVrUEoNUghr2g7Xok8eAhuWnpf0si/ECZ/Rhw6njAYSPvjGATUX/G2gkgswiJ2czfMkM=
X-Received: by 2002:adf:81e1:: with SMTP id 88-v6mr38205054wra.19.1539963069081;
 Fri, 19 Oct 2018 08:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com> <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com> <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com> <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <c6880c5b-e259-4923-8d5a-80c620563398@amd.com> <20181008174628.GB11442@roeck-us.net>
 <4a1faa3b-8c42-b742-9b55-9d2711f7ecc1@amd.com> <20181019085308.GY31561@phenom.ffwll.local>
 <8081f60d-ef19-14a5-a589-874afc050d94@roeck-us.net>
In-Reply-To: <8081f60d-ef19-14a5-a589-874afc050d94@roeck-us.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Oct 2018 11:30:55 -0400
Message-ID: <CADnq5_PFdgZFfejWKdt6jp-Fc1sHDgX6F8kcCpAO4BmpDHHsEQ@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christian Koenig <Christian.Koenig@amd.com>, peng.hao2@zte.com.cn,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Martin Peres <martin.peres@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 9:31 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/19/2018 01:53 AM, Daniel Vetter wrote:
> > On Mon, Oct 08, 2018 at 06:13:56PM +0000, Koenig, Christian wrote:
> >> Am 08.10.2018 um 19:46 schrieb Guenter Roeck:
> >>> On Mon, Oct 08, 2018 at 05:22:24PM +0000, Koenig, Christian wrote:
> >>>> Am 08.10.2018 um 17:57 schrieb Deucher, Alexander:
> >>>>>>>> One thing I found missing in the discussion was the reference to the
> >>>>>>>> C standard.
> >>>>>>>> The C99 standard states in section 6.7.8 (Initialization) clause 19:
> >>>>>>>> "... all
> >>>>>>>> subobjects that are not initialized explicitly shall be initialized
> >>>>>>>> implicitly the same as objects that have static storage duration".
> >>>>>>>> Clause 21 makes further reference to partial initialization,
> >>>>>>>> suggesting the same. Various online resources, including the gcc
> >>>>>>>> documentation, all state the same. I don't find any reference to a
> >>>>>>>> partial initialization which would leave members of a structure
> >>>>>>>> undefined. It would be interesting for me to understand how and why
> >>>>>>>> this does not apply here.
> >>>>>>>>
> >>>>>>>> In this context, it is interesting that the other 48 instances of the
> >>>>>>>> { { 0 } } initialization in the same driver don't raise similar
> >>>>>>>> concerns, nor seemed to have caused any operational problems.
> >>>>>>> Feel free to provide patches to replace those with memset().
> >>>>>>>
> >>>>>> Not me. As I see it, the problem, if it exists, would be a violation of the C
> >>>>>> standard. I don't believe hacking around bad C compilers. I would rather
> >>>>>> blacklist such compilers.
> >>>> Well then you would need to blacklist basically all gcc variants of the
> >>>> last decade or so.
> >>>>
> >>>> Initializing only known members of structures is a perfectly valid
> >>>> optimization and well known issue when you then compare the structure
> >>>> with memcpy() or use the bytes for hashing or something similar.
> >>>>
> >>> Isn't that about padding ? That is a completely different issue.
> >>
> >> Correct, yes. But that is the reason why I recommend using memset() for
> >> zero initialization.
> >>
> >> See we don't know the inner layout of the structure, could be another
> >> structure or an union.
> >>
> >> If it's a structure everything is fine because if you initialize one
> >> structure member all other get their default type (whatever that means),
> >> but if it's an union.....
> >>
> >> Not sure if compilers still react allergic to that, but its the status
> >> I've learned the hard way when the C99 standard came out and it still
> >> seems like people are working around that so I recommend everybody to
> >> stick with memset().
> >
> > Went boom:
> >
> > https://bugs.freedesktop.org/show_bug.cgi?id=108490
> >
>
> What went boom ? This patch wasn't accepted, and I don't immediately see
> the correlation of the suggested revert with the rejected patch.

Daniel accidentally replied to the wrong thread.  Please ignore.

Alex

>
> Guenter
>
> > Can we revert?
> >
> > Also, can we properly igt this so that intel-gfx-ci could test this before
> > it's all fireworks?
> >
> > Thanks, Daniel
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
