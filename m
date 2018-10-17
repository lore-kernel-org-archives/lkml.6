Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F694C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4165214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifGLbXmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4165214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJQLC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:02:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41723 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJQLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:02:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23-v6so11794458pgc.8;
        Tue, 16 Oct 2018 20:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M8dsvmIzTHKKVGxULcihjzEM6chTWJouSjLpkb54LPM=;
        b=ifGLbXmcpizvBdesXdgVMr3YZTGTF/CtB0PZe7ML9KFJBzRwhDmiJyMgx7mG+ZW2p8
         9lVfxt/FkFbj6KD6Xnr/DScxUbxk4MH6jpBI/w9sqr5dIgQGWrdoAFF1mslp+/A6fT+n
         EDvtfxfu514wq6RTVMwmLXFRLDQki4cxwhx0Gl2Nz7LpCGJOIW62uaMyohLO3FwrKJu4
         4Ft7izkRpIAarqu2l9MsjiVXuM8OfjkAZx5vfgNena+Vh3/vqsBRe79nQAjiIMDlwvAg
         ynsxhnlqDkpoaWpQtOfOzpNRSOV3i4pyAyXP3mx2UbAOX6YAHUAhWbOZMWL4A2C9BkyK
         Wyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M8dsvmIzTHKKVGxULcihjzEM6chTWJouSjLpkb54LPM=;
        b=rp4+xJwxfZJGmRUNN9pg3Eta7gQCto4FDJEOgiqD/lYdB8g4gnanPuB67NyXqRU+O4
         iNVnSUomBxVdXHSrbnPBMwnap3O+gBZOOxX0ELHryonc3mPcDyn2mjBl69xrKBcxKXFV
         +GCubMTYWTXzdCJDxHKKdPrO4I4VCgELY38SiGa9P0RJ3cykq1QY5CgC7k/1GBM7Osjo
         +M3wHM/tPAblnKpBDc32Hfjj6GATkzIoZrKeMDDXL1bvgXYHx8Yvr7XAef6sby/4VMmv
         72YsfSuDR85fouhcnJa0p8VG5NtbpQBtDgbarMvQM9a3v6DsiGXfDLIraYuDXW7MSU0H
         Yb1A==
X-Gm-Message-State: ABuFfogpUdc8i1rvpZnTNdtxGAII1aNXUtROixpu6FKSlLoZ03nAcMrO
        uGUaNZlHHXLieZJDD+Vx0IEWcrtv
X-Google-Smtp-Source: ACcGV62utJhNiCiVnZIOUxf7080hkbzQIIGCr2VOMiRJS8kPQdoYy/Na/J1D1Me2MFpc6n7vtLLA8Q==
X-Received: by 2002:a65:5347:: with SMTP id w7-v6mr23278154pgr.17.1539745738177;
        Tue, 16 Oct 2018 20:08:58 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r23-v6sm17618979pfh.79.2018.10.16.20.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 20:08:57 -0700 (PDT)
Subject: Re: [PATCH v4 00/18] of: overlay: validation checks, subsequent fixes
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <87murekyts.fsf@concordia.ellerman.id.au>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <bbbbe52c-8415-e22a-48d7-95f919942c68@gmail.com>
Date:   Tue, 16 Oct 2018 20:08:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87murekyts.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/18 02:47, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add checks to (1) overlay apply process and (2) memory freeing
>> triggered by overlay release.  The checks are intended to detect
>> possible memory leaks and invalid overlays.
>>
>> The checks revealed bugs in existing code.  Fixed the bugs.
>>
>> While fixing bugs, noted other issues, which are fixed in
>> separate patches.
>>
>> *****  Powerpc folks: I was not able to test the patches that
>> *****  directly impact Powerpc systems that use dynamic
>> *****  devicetree.  Please review that code carefully and
>> *****  test.  The specific patches are: 03/16, 04/16, 07/16
> 
> Hi Frank,
> 
> Do you have this series in a git tree somewhere?
> 
> I tried applying it on top of linux-next but hit some conflicts which I
> couldn't easily resolve.
> 
> cheers
> 



git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git

$ git checkout v4.19-rc1--kfree_validate--v4

$ git log --oneline v4.19-rc1..
2ba1b7d353dd of: unittest: initialize args before calling of_*parse_*()
4f9108209f79 of: unittest: find overlays[] entry by name instead of index
353403c76ff8 of: unittest: allow base devicetree to have symbol metadata
8fc37e04a01b of: overlay: set node fields from properties when add new overlay n
05d5df0e5151 of: unittest: remove unused of_unittest_apply_overlay() argument
8c021cba757a of: overlay: check prevents multiple fragments touching same proper
797a6f66e039 of: overlay: check prevents multiple fragments add or delete same n
c385e25a040d of: overlay: test case of two fragments adding same node
c88fd240f0e0 of: overlay: make all pr_debug() and pr_err() messages unique
1028a215d32a of: overlay: validate overlay properties #address-cells and #size-c
f1a97ef74ce4 of: overlay: reorder fields in struct fragment
ffe78cf7a1fb of: dynamic: change type of of_{at,de}tach_node() to void
5f5ff8ec0c0c of: overlay: do not duplicate properties from overlay for new nodes
06e72dcb2bb0 of: overlay: use prop add changeset entry for property in new nodes
a02f8d326a08 powerpc/pseries: add of_node_put() in dlpar_detach_node()
e203be664330 of: overlay: add missing of_node_get() in __of_attach_node_sysfs
8eb46208e7c8 of: overlay: add missing of_node_put() after add new node to change
b22067db7cf9 of: overlay: add tests to validate kfrees from overlay removal
