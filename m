Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CD4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5EB204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtYf8Big"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5EB204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJQCL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:11:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44981 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:11:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id m18-v6so17731361lfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VTqpykZbu5dnLt2G6I5k9ezwTwb1Dv5K5J5VvPZI9W4=;
        b=HtYf8Bigky96EFrQTYymdDVvnZvu+X2XNma6mwJFDhQB6cE6p5b1H9VNvvpAmkyCMY
         CYYUJ09ZSLIHVbbaU7Vbai178984xJ6DjPZD2OAX6G3I8lrE+UajQxfXlws3F47QvYMk
         j2hx0u6iNGlRw76VqU6JgqaxPHGmwxfpvkTng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VTqpykZbu5dnLt2G6I5k9ezwTwb1Dv5K5J5VvPZI9W4=;
        b=dhNCK5r/CpYdJMoIvAaNoMrd1amQoXvh8NDu4/BL/4yTY3hupLVXuAL639GkveUPfm
         CIoS2I8Ngrki/h86tl0p/Zod6rwdjBlrdNf3O70s6kyKfFGrXf5H1QJ4TpqMc+F+Fjke
         YLnPWurqtp12irFD3J5hA1zxtPocNupDPErmNi8WtNTMecjJfLZn/IM0l3WU7NKjspAj
         lsynvkLH6hET43HCJbxDqxTEY5qBxtT41v/90fPmZJzUZWD5qLQ4PllxUh1Fg/eNx7/y
         YVRsdbSBp57BDmgTU0mEs4IClbVezBrQLiHzjZELTQYqXHNuzhWJPEIpxhDrdCmkfIF2
         12Hw==
X-Gm-Message-State: ABuFfohH00sjp4KXlJAqQZPYh0/Js8CLQgMuQWk8EKJSzCnRj3UoyVAm
        bAcj1kc/ur8g8olwruYvSBVkXcbgGH5etP1//jONag==
X-Google-Smtp-Source: ACcGV60bu3JBjQATx+E1iuBE0VwMwgzwhfvfx0E1rn4CooNXDWoxVkl2VqM5KMSQ+cphkoovhIw1orqrcbFzs6Xy5EE=
X-Received: by 2002:a19:6719:: with SMTP id b25-v6mr13256009lfc.54.1539714015062;
 Tue, 16 Oct 2018 11:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181016170220.31156-1-daniel.diaz@linaro.org> <037e072a-5695-1343-35d1-37b9450581d4@kernel.org>
In-Reply-To: <037e072a-5695-1343-35d1-37b9450581d4@kernel.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 16 Oct 2018 13:20:03 -0500
Message-ID: <CAEUSe79cj8i6kH1O2a6vJO8RHnEPVMx5UjbVvxsJqRZ38N5wBg@mail.gmail.com>
Subject: Re: [PATCH] selftests/ftrace: Use colored output when available
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, 16 Oct 2018 at 12:43, Shuah Khan <shuah@kernel.org> wrote:
> On 10/16/2018 11:02 AM, Daniel D=C3=ADaz wrote:
> > If test is being directly executed (with stdout opened on the
> > terminal) and the terminal capabilities indicate enough
> > colors, then use the existing scheme of green, red, and blue
> > to show when tests pass, fail or end in a different way.
> >
> > When running the tests redirecting the stdout, for instance,
> > to a file, then colors are not shown, thus producing a more
> > readable output.
> >
> > Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
> > ---
>
> Hi Daniel,
> Thanks for the patch. Steve is working on adding this functionality. Plea=
se
> see the latest linux-kselftest next for the patch.

I hadn't seen today's discussion until after Steve replied to this
patch. Mine is based on your next branch, building upon Steve's patch.

These changes here are somewhat different, in that color is enabled
only if color is available in the terminal in the first place! And if
the standard output is redirected to a file (which is what Masami
reported today), then colors are avoided even if available.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org


> Steve just sent an update to the patch to fix an issue. Please test and s=
ee
> if that solves the problem you are trying address with this patch.
>
> thanks,
> -- Shuah
