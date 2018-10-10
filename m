Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BF0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EE3214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMgemq54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EE3214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJJPvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:51:19 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:32943 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJJPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:51:19 -0400
Received: by mail-io1-f73.google.com with SMTP id c5-v6so3957062ioa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QbwKYhSfxwULP2FXAMY4wF+W2exTtSNx+KR8PRP4UU8=;
        b=uMgemq54ng8pXyt7n290rfAQspGaaqZMK8x+oWEjPEYuYHh4CzsUJ0SSfVxUFlKR++
         sW9bpaTQnJUVPe3H8JR2zy/S18h2lv31kL3jFFM+RSarMGCk0BE1WABLbx4xMXILAp3H
         37aW69dCq2TjsPVOb2jOb8ipmzq69bumlft3VTNUjvFxDqis60fO7NzuS4AugglDxSFk
         D0+gXXSry5jW8NqfZvxvXg91NBJ89xml/B2YnY2Qb6+k7Xwjb6T+Kng+TzzSvxkYtC3r
         YzpAyQ5eAv3wyZz+kCfyOkDM7Ujo86oL4LVtyrZKqtPmcXhr4M+VofH+28HvhtouVJaD
         Ur4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QbwKYhSfxwULP2FXAMY4wF+W2exTtSNx+KR8PRP4UU8=;
        b=n/jPvWQvvpTQUd7rE951a4IVKE/XqN3UacWX+7wp1QUFiCecUQnEYe7g+z20RJ96UM
         pb4qrjWqev83nybWCPPDBG0+fKmP7tkQiJJ1PaH5oZxqeXavfSzrPQ7EPcXPYr76ESPd
         XA1vqV0Ruu20ihg901DhrDKcJX3Fx0JQO4K1rjEe9E4mGozCHG/lKKSxX91OT0OSBKCU
         sCl0eBGiko0C49x/8uAi2sUmWRn45roRusHcRSBGgGEQLNisSPzGfUfTIijfYkc2cMYJ
         Mi20g0nNeNk/eHv02946nqQcLhgnEvF2HT+3QSsPvVunqrQtvWVomsr7oqsuRHo8IgKg
         leyQ==
X-Gm-Message-State: ABuFfoi+4ZTWN0YFxf0v12se/Dw5Y/WksXFtQPJrOZ/TXTRPzybSAgeI
        GaEBmxFXcQCL1OfFoiAu85ZILCbEYlZyuBC/4l6yaUdxUMu9m9XGmsANLaeORrWvLTvjCBaQkVo
        so4NraHAThqetpvqEp5Zh4B/RP8oKJApE004NXHfPcNSUD1V2+vdlqN7mxVMWvYJ76FNlax8uc6
        Gfecb76BTZMmlMqPw=
X-Google-Smtp-Source: ACcGV60em0r+oRSv9ZwFkqG1AeQbY/kL+fDqj149UBB9H/S5pq+G6oF1p9a5PQYj3f6NjV1Dl1ewkNdENctZecfZwNztGw==
X-Received: by 2002:a24:73c2:: with SMTP id y185-v6mr3779itb.32.1539160213707;
 Wed, 10 Oct 2018 01:30:13 -0700 (PDT)
Date:   Wed, 10 Oct 2018 01:30:05 -0700
Message-Id: <20181010083007.239938-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: Expose all known Intel DPTF policies
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Dynamic Platform and Thermal Framework is a combination
firmware/OS framework for allowing userland to implement more complex
thermal policies in conjunction with the platform firmware. The rough
gist is that the firmware exposes a set of information describing the
relationships between various heat generating and heat removing
components in the system, the OS makes a reasonable decision about what
sort of policy will work best given the constraints the system is
currently operating under and passes that decision back to the firmware,
and the firmware does some magic (potentially including reprogramming
various CPU MSRs) to match the OS policy. Depending on the policy, the
OS may then be responsible for ensuring that the system stays within the
appropriate thermal envelope.

Linux already has a driver that exposes the firmware interface for
setting the policy, but it's somewhat broken - it only exposes a very
small subset of the defined policies, and most new systems don't
intersect with the exposed ones (strangely, support for some policies
was actively removed in 31908f45a583e8f21db37f402b6e8d5739945afd). It
also doesn't actually /work/ on any new systems, since the PASSIVE_1
policy seems to have been replaced by the PASSIVE_2 policy and therefore
it's impossible to actually trigger a new UUID write.

The consequence of this right now is that various new systems (such as
most current Thinkpads) default to a safe policy that throttles the CPU
at a low temperature, dramatically reducing system performance. Since
Linux provides no mechanism to set any of the other policies the
platform supports, users are stuck. This patchset adds all the UUIDs
I've been able to find from scraping various ACPI tables, and fixes the
mode setting in order to make it possible to actually set the new modes.
It should be noted that this is nowhere near an actual solution - doing
this properly requires appropriate userspace management tooling, and
Intel haven't documented most of the ACPI information required to make
it possible to write such tooling. However, this is a first step in
making it possible to do that work.


