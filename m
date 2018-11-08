Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14280C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D584B20837
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D584B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeKHL70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:59:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33369 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeKHL70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:59:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id q5-v6so8176024pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d1wTShLA8tfcEf/d3Ubsk49/Ldf123MkB0jTx9bO5CA=;
        b=sD4Nn0YONL2FMtFPK8NDQYo+sXDtlj2Jof0YDFIM9zvBCR8e7VT3Yk09fNzKG8b7bI
         GhAlGdEVSVdN+7irJMBn5NgtpZAexaBBejXuItcwqb7V0OlInmEY3psFq8fmxk3BVSdL
         kbJ2sdR9UqEw6gWU7TmIWuzM63h52Z8zYjQBEzO0Fxv+nGdw74zzGS+HYLSTU9sqeSjY
         xRw7a5Wgci2/w2Fahnyc0wGVD+V4fGGlMVmyAHbMLXkom00lhL2+awH6F37uPRg+v3k9
         gNvhDg4ohjHQUYAQIRr/jAwadHYRUsd/YXmPxDHlaOs7tzw/uN+6RFIgfivlBx86hQgs
         aiJw==
X-Gm-Message-State: AGRZ1gJLMfPq/wPgzT3tai2h2xVGfTFQgKFItB9Mv5AFiM1ZClGXIcU4
        UqpG+PJeliDgjaMGbi8rWlzRnoY/
X-Google-Smtp-Source: AJdET5fpPJMeaJPSzL8d2PWWMluRecKECqyXUohXFYcfWqMPNcBtPIJFOxrYMtPyfVpYCU0riegTbA==
X-Received: by 2002:a62:85:: with SMTP id 127-v6mr2758556pfa.24.1541643974876;
        Wed, 07 Nov 2018 18:26:14 -0800 (PST)
Received: from asus.site ([2601:647:4601:5d98:fb3c:91c5:1423:24cd])
        by smtp.gmail.com with ESMTPSA id z8sm1827440pgz.53.2018.11.07.18.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 18:26:13 -0800 (PST)
Subject: Re: [LKP] [drivers/base] 1431aa42b3:
 WARNING:at_drivers/base.c:#device_bind_driver
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Lee Duncan <lduncan@suse.com>, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>, lkp@01.org
References: <20181108002442.GH24195@shao2-debian>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <78791260-c029-4ce8-d44a-61f3a9b392d1@acm.org>
Date:   Wed, 7 Nov 2018 18:26:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108002442.GH24195@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 4:24 PM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 1431aa42b3afc1dd50b292abcc68ccdc3193da63 ("drivers/base: Verify struct device locking requirements at runtime")
> https://github.com/bvanassche/linux for-next
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu IvyBridge -smp 2 -m 2G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> [ ... ]

A fix has already been pushed out, so I think this report can be ignored.

Bart.
