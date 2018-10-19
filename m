Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E84FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D8B2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s45Wc0k0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D8B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeJSNEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:04:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33903 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeJSNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:04:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so15242798pgs.1;
        Thu, 18 Oct 2018 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sLS02Ys+OMIWhw+yNf5/06qzYeiO5cQY5DdT8X34mjU=;
        b=s45Wc0k0Byoj2VVd+itXhQaAdS3xZwW8qY/k1ZDe6vyOX/GVyITR+P/1um4jMHzIx7
         ZD7XgV4FBRkcelP4ABKxfzU3JsbZQ/kZuFOYW8hwmPrryZ/GiO1HkTG6F2xQCO9ACe89
         r/xXsuY6BdeHqvfOhqjulMhvQRiib88P2vyT1iL2Krbd9e9Tv85z/ATHjHiutA4gbx3X
         zgS0eeLBpbQl3eoZSui0nUSvE1o1cfyAz8kMV+x1RzM9/mQUc6HLBd0XSJuskw7AwJlE
         nAjmIwUrJlpSV4d+tQj6X07fR/MohCPAHp2d4qcj+ggiCFZwJVLol4KSEN9c+o1yrayH
         Ot4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sLS02Ys+OMIWhw+yNf5/06qzYeiO5cQY5DdT8X34mjU=;
        b=bS5PXt3gUzbQhKTu8Xwe4KGlKUCCEnsQiKhncTfB6PqJj5m6gHZgVF4eXsK2tnavj2
         ZuKXRBipcPn8YF7jx3YfUjnkoZsF0JZ33a3BfN2TBqs0s78zDhg3Tc4FeIrJ6FIZYOKz
         FRjtMegSm0zangG654L6d+FCccV3fwo/ju3NT7sbiFLfaqadlrJR0k4K79e+dhONiPZK
         6Lnxvg8eMV0gbTZXzmQ6EU7mGkndQaRSxpiU0+v8n1x7FXP8cAVgHFBQ+kIZaLh4zldV
         mUBIOVs5v4rmqIjGlaWM0Oi7BT45LqiE/RsN+4X3/G/eHHJ806fpLVpgBcKC8ogidYMe
         nG/A==
X-Gm-Message-State: ABuFfoj8sAXjegRqCec8leQfz29yvYNcADX6KMSlZ9CCb4/neTovTZSx
        DC3+LBs4vzenuo0qUSh+EWl1Iv6w
X-Google-Smtp-Source: ACcGV61CCl6CBmfAeR+uXrxnDlA6la1edxKuEVcTLg4w63AJov7qKKF8wfFoOYf5d7b+71J6qUiQZg==
X-Received: by 2002:a65:4882:: with SMTP id n2-v6mr29726099pgs.225.1539925209479;
        Thu, 18 Oct 2018 22:00:09 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b81-v6sm40921622pfm.96.2018.10.18.22.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 22:00:08 -0700 (PDT)
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Message-ID: <5d8a5e46-b186-9c15-890a-ae6481652eaa@gmail.com>
Date:   Thu, 18 Oct 2018 22:00:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 15:46, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.
> 
> The checks revealed bugs in existing code.  Fixed the bugs.
> 
> While fixing bugs, noted other issues, which are fixed in
> separate patches.


git version of the series:


git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git

$ git checkout v4.19-rc1--kfree_validate--v5

$ git log --oneline v4.19-rc1..
62e8f28bb14b of: unittest: initialize args before calling of_*parse_*()
cc8b630f0c7f of: unittest: find overlays[] entry by name instead of index
b80a8e974e0f of: unittest: allow base devicetree to have symbol metadata
bbcd6ead8e36 of: overlay: set node fields from properties when add new overlay node
e02d06f99646 of: unittest: remove unused of_unittest_apply_overlay() argument
484ba7f7eb4a of: overlay: check prevents multiple fragments touching same property
4640b81a605b of: overlay: check prevents multiple fragments add or delete same node
698f942ee230 of: overlay: test case of two fragments adding same node
5fe758e00f1f of: overlay: make all pr_debug() and pr_err() messages unique
868c6f70eed5 of: overlay: validate overlay properties #address-cells and #size-cells
06bc44ce477f of: overlay: reorder fields in struct fragment
584f4537377c of: dynamic: change type of of_{at,de}tach_node() to void
54f30ea3bf65 of: overlay: do not duplicate properties from overlay for new nodes
ad4180c300fc of: overlay: use prop add changeset entry for property in new nodes
b1bdca739700 powerpc/pseries: add of_node_put() in dlpar_detach_node()
8e0290d5cb62 of: overlay: add missing of_node_get() in __of_attach_node_sysfs
93e221495a9f of: overlay: add missing of_node_put() after add new node to changeset
86043f08e539 of: overlay: add tests to validate kfrees from overlay removal
