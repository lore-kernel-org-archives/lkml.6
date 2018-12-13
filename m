Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F447C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E716220811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="maV3/D+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E716220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeLMAZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:25:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37073 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLMAZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:25:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so168829qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=A64BPClTcxiSyPtp56UdFOq8YwKHJlUGO/a9VoH1EDs=;
        b=maV3/D+KEsMAHonoHlZrb9FrTnK8r4bWbkvygtZWv1iC44RdXERIkwc7b7v4ZrHKct
         oa8RF28z0DEDiR6h2Ms2g8DhKs3BT+sK8jZl+1u50CMhw5x5n27PZHFwIqWO8hWyaSVy
         tfulLWuS/LWg7+W+miWfOBbrYD0Rc+B85FN3CCLmW1RKrzy8zjlJ53g1jZOT9KogdjHu
         z5nYhX8EtPdZIQvbNQXRSs3qSxlu3J51Y97xb3zC0KDU/Y6/FouKBcl6BcnQ6m2VKl8b
         u0MfYHsNsBNG0FpzN5/ApsBEc1hlPMvvF9Q3EYC32BNf0Kn2O4v+hkEN82asmjSFnOUn
         TvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=A64BPClTcxiSyPtp56UdFOq8YwKHJlUGO/a9VoH1EDs=;
        b=dCQJH7qHd1j+e69GwOraAP52ajEWaYTHdQp8Y6OVpYijuoj6/1UJVaUZQu41IGGDXc
         0CuXMtBcFcNW8WYAk9Oj8677HSbnBv6xhQ3dmC9jl/P6HkM/VseGpXJY1nB6z8EpzNju
         pBbd2k96504ct43AfUtE7wiuIhc0bogFqoS7OJI1qMUH8ZiN9JdmDL4GsKR6ee4f5mC+
         sQCcbu040UtebU5f7CHNuqsi0sq/SveK7girAzTTDewupBvj+1XS0iRvqL8hWS5qwqjX
         WlQ011ULrcVaKAgMa0z3yKch9PEZ6u7WDtGtiQyEc7G4ktIm5qL1cVR3X4lbXZ7elN3V
         cLLw==
X-Gm-Message-State: AA+aEWa8HOtNyjCZ4IGv6bPUrvFCf+kY28QoNBR72a4T/uWu94v1OCMt
        brRu2af5xNYs6p8/dSW8q8kVsQ==
X-Google-Smtp-Source: AFSGD/WfC7XdfKIfh0LYO4qRvAMKWUKis1+Gf/oKREB0Fy+3M0D9X0H13ES8sX1g4nXXZmgETVEAvA==
X-Received: by 2002:ae9:f212:: with SMTP id m18mr19613776qkg.5.1544660707820;
        Wed, 12 Dec 2018 16:25:07 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c77sm248662qkh.82.2018.12.12.16.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 16:25:07 -0800 (PST)
Date:   Wed, 12 Dec 2018 16:25:03 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Edward Cree <ecree@solarflare.com>
Cc:     Alice Ferrazzi <alice.ferrazzi@gmail.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <shuah@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] selftest/bpf: remove redundant parenthesis
Message-ID: <20181212162503.6fe270f6@cakuba.netronome.com>
In-Reply-To: <31fc0e28-8f34-1b44-c6b1-9441c6e26c9e@solarflare.com>
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
        <20181211115607.13774-7-alice.ferrazzi@gmail.com>
        <20181212110404.2e211ef1@cakuba.netronome.com>
        <31fc0e28-8f34-1b44-c6b1-9441c6e26c9e@solarflare.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 21:15:52 +0000, Edward Cree wrote:
> On 12/12/18 19:04, Jakub Kicinski wrote:
> > On Tue, 11 Dec 2018 20:56:06 +0900, Alice Ferrazzi wrote: =20
> >> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
> >> ---
> >>  tools/testing/selftests/bpf/test_offload.py | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testi=
ng/selftests/bpf/test_offload.py
> >> index 0f9130ebfd2c..b06cc0eea0eb 100755
> >> --- a/tools/testing/selftests/bpf/test_offload.py
> >> +++ b/tools/testing/selftests/bpf/test_offload.py
> >> @@ -140,7 +140,7 @@ def cmd_result(proc, include_stderr=3DFalse, fail=
=3DFalse):
> >> =20
> >> =20
> >>  def rm(f):
> >> -    cmd("rm -f %s" % (f))
> >> +    cmd("rm -f %s" % f)
> >>      if f in files:
> >>          files.remove(f)
> >>   =20
> > Is this in PEP8, too? =20
> I don't know, but it shouldn't be.
> If f is a sequence type, both the old and new code can break here,
> =C2=A0throwing a TypeError.=C2=A0 It should be cmd("rm -f %s" % (f,)).=C2=
=A0 The
> =C2=A0presence of the brackets suggests to me that that's what the
> =C2=A0original author intended.

Agreed, that was my intention, I didn't know about the comma option.

> Now, it's unlikely that we'd ever want to pass a list or tuple
> =C2=A0here, since 'rm' wouldn't understand the result, but the proper
> =C2=A0way to deal with that is an assertion with a meaningful message,
> =C2=A0since the TypeError here will have the non-obvious message "not
> =C2=A0all arguments converted during string formatting".

Interesting, thanks for the analysis!
