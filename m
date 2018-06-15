Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA4FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900AA2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwj6WqML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900AA2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936334AbeFOTHa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:07:30 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:42977 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934701AbeFOTH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:07:28 -0400
Received: by mail-yw0-f170.google.com with SMTP id q7-v6so3689023ywd.9;
        Fri, 15 Jun 2018 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLlAj4iPfNUfXXqcTzAK1dScCO4gTP4X+zVMnNbdWA0=;
        b=qwj6WqMLpNc0i7I/IJ0Olx7H/nG7GF7oGSzPv5n4kOw59ALSZWnsyZmtFMrfFwue2+
         4pIh9t/22UMS64jPhcRvsNZQOMkx2cojhYDvZUK/+rer+ZWUeWORhId3mBfxAWa4oK1M
         XCho0AjDI/5WpVg7MorWRjcolFJk8+Efanx9mrXZDu9jMiLU2RoiR9DVqgy5XWnWP7pr
         2Hwm2ycy6XorBUOoXU0mQphRdWyWjc0PvZd82gSzjgd0QBUpXJg9nB15uDJZheYGepAi
         Do1pkQB8o03Fe5c1V6GkBbfvhxfzOcHB1hwq0Me4LH4zAYz1/VvxeTPae8PHFXDyglyD
         Lfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLlAj4iPfNUfXXqcTzAK1dScCO4gTP4X+zVMnNbdWA0=;
        b=OtUuW31logVKAeVjOIkmqgcDHk8aDDguAfJuSkirXcGU+St++6YkgDNYos2KidxDSv
         cRXo3AFERt3LCvJDYyTuWWMKi02hct0YadtSabW9ZOZviTIUcvXxNNJxXn315PyI8oEm
         riqedf2qCerIokfndog8e3iicUILLagGcTih01jmTNSEnUmemjkMoFm2LrxqWPnkYFlD
         hyWF88qVmggTIM4bQt3GJrSUDM+gMANW/OssPemd6DXCK3W4RnNJOWshO58Cfql8kVrV
         4gDhA4VbbQKrW1egeuxmmm8NcAgt4BXB00dQXWL4WUekxl3CFSqxM0KBPYgSjTSWaB4Q
         t5yg==
X-Gm-Message-State: APt69E2KOW7McIVX8figATLaAzwbFBcFS4qAOvS2HJP/rBHVvRBJ+IJq
        vjBj+Jhx8YbZ9OoKRL7ullY=
X-Google-Smtp-Source: ADUXVKLRwiYGQSBeMkRH8GhDFVTFHU/MDtf/vM30uUp4NllhJIxhbh+ezw46Udy5l56lAGTuBbBSpQ==
X-Received: by 2002:a81:9f8e:: with SMTP id w136-v6mr1507731ywg.157.1529089647903;
        Fri, 15 Jun 2018 12:07:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:f114])
        by smtp.gmail.com with ESMTPSA id w72-v6sm3493705ywa.74.2018.06.15.12.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:07:26 -0700 (PDT)
Date:   Fri, 15 Jun 2018 12:07:24 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ivan Zahariev <famzah@icdsoft.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Cgroups "pids" controller does not update "pids.current" count
 immediately
Message-ID: <20180615190724.GX1351649@devbig577.frc2.facebook.com>
References: <77af3805-e912-2664-f347-e30c0919d0c4@icdsoft.com>
 <20180614150650.GU1351649@devbig577.frc2.facebook.com>
 <7860105c-553a-534b-57fc-222d931cb972@icdsoft.com>
 <20180615154140.GV1351649@devbig577.frc2.facebook.com>
 <1d635d1d-6152-ecfc-d235-147ff1fe7c95@icdsoft.com>
 <20180615161647.GW1351649@devbig577.frc2.facebook.com>
 <6c2c9bfb-3175-b9ec-cf39-c9d4ebf654b2@icdsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c2c9bfb-3175-b9ec-cf39-c9d4ebf654b2@icdsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ivan.

On Fri, Jun 15, 2018 at 08:40:02PM +0300, Ivan Zahariev wrote:
> The lazy pids accounting + modern fast CPUs makes the "pids.current"
> metric practically unusable for resource limiting in our case. For a
> test, when we started and ended one single process very quickly, we
> saw "pids.current" equal up to 185 (while the correct value at all
> time is either 0 or 1). If we want that a "cgroup" can spawn maximum
> 50 processes, we should use some high value like 300 for "pids.max",
> in order to compensate the pids uncharge lag (and this depends on
> the speed of the CPU and how busy the system is).

Yeah, that actually makes a lot of sense.  We can't keep everything
synchronous for obvious performance reasons but we definitely can wait
for RCU grace period before failing.  Forking might become a bit
slower while pids are draining but shouldn't fail and that shouldn't
incur any performance overhead in normal conditions when pids aren't
constrained.

Thanks.

-- 
tejun
