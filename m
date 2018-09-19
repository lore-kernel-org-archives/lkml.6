Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A20AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7EF214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5D0xziS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7EF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbeISGki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:40:38 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41225 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeISGki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:40:38 -0400
Received: by mail-qt0-f169.google.com with SMTP id t39-v6so3605407qtc.8;
        Tue, 18 Sep 2018 18:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=S7iM84fxyCSJaQvOS/XDlPfh0BB8h2HL48X+QsuqhSU=;
        b=c5D0xziSsuvUtv4AAoLH1Q0rRcTLv5/7M5Hjhbro7iBzWGFxsTpY64i+i8+ac+3EUD
         9/3lQq7n4iVmLmhKJeK5diRisxwL7mAgeCMZVKTnjYe7vqE3TWPS86eaU6/HZBJnHMnb
         gD35qb9aGHC4Q8N5V9ffJ6QOxXmd2JhHvjHjTxd6y95C802kflXW1lDFJP/LTYkZgFzB
         L+rCTcmD1Co/Chfi/lQxoV7swLsvp4KUAcGEZGMJ2CXjOR3Q7HQJzpqM05UbYAuRxJW2
         NLO7DdbDD7q1TlDmZlGMEVZ9aH9oHb7tQfkoTSiAieF4NGpgfQGczXNxTCEPFaiIg92m
         FKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=S7iM84fxyCSJaQvOS/XDlPfh0BB8h2HL48X+QsuqhSU=;
        b=Xt4Yn8LrjhLy7E86RCgQxn5ZY/2SsYmjUzo2ZOrzwVz6naquIhIjRcthfReZq149ug
         GaJ55t1dopdy+1mIDfda0xi6bysoQNfkHsN2dCCMQLEQ5l1JGqEWXjLDkEMRGWTM+Kki
         HsElE3DSIQdizjoC5qeVx7oWEd1CRyLNgA8VbjtzHQkj5GKGACkT7tYGRu2hWiIESIbt
         yUgT6yLugcYrnbt0MWRmeBzzlzANgHFSJff0AeuWt1PFNb6foF6szgOlcUFP9BAS9Ehx
         3cTlbbR7klWyQ8OkZolpaZqcIR/iojdZJ3Goua/5kM33CYK+xVDx9O4cN8DYlfcX2T+d
         17NA==
X-Gm-Message-State: APzg51DN8Zp8dKsxny04pjiRB6W1GQKcJa+IsziOAAjubFSIg6Kib0Jw
        lgZAqJ0VsOLYYjdl9ujRrappELQS
X-Google-Smtp-Source: ANB0VdYMqYH3y/6sEFwHJ4XNb/OsTKY22jwbRPGDrAe+laEB5ELP6ZpKv5LIVWQWp462hmC/X6Lj/A==
X-Received: by 2002:aed:3de1:: with SMTP id j30-v6mr22778374qtf.266.1537319122655;
        Tue, 18 Sep 2018 18:05:22 -0700 (PDT)
Received: from [192.168.1.170] (pool-108-20-161-100.bstnma.fios.verizon.net. [108.20.161.100])
        by smtp.googlemail.com with ESMTPSA id 17-v6sm1229831qkf.74.2018.09.18.18.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 18:05:21 -0700 (PDT)
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Brian Dodge <bdodge09@gmail.com>
Subject: arc vendor prefix
Message-ID: <527da392-9629-792b-08cc-970ffc8173ee@gmail.com>
Date:   Tue, 18 Sep 2018 21:05:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the linux kernel commit 91ab076e3a2f092254fe5231bbfa92b37fd52e38 the 
vendor prefix "arctic" was added to vendor-prefixes.txt.

The original change I authored used "arc" not "arctic", and the device 
tree bindings were added assuming that prefix in commit 
ce9d22573d85341c987f997461ac712e4dbe47b1

Perhaps odeju changed the name to arctic in the patch after I created it 
and before it was approved.

This pairing isn't really compatible is it?  Either the prefix should be 
reverted to "arc" or the bindings (and driver source) changed to use 
"arctic", as in "arctic,arc2c0608" vs. "arc,arc2c0608"

The arcticsand company is now part of psemi (formerly peregrine 
semiconductor) and they would like to keep using the arc prefix for 
these chips and in the driver and I plan on changing the 
vendor-prefix.txt to reflect that.

I am in the process of updating the driver code to support different and 
new variants of the chip and would like to know what the preference is 
for this prefix going forward.

Thank you

Brian

