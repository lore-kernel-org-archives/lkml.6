Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD3EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683BA219F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unt0tACK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683BA219F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeHHSyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:54:23 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53753 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHSyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:54:22 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so4284664itw.3;
        Wed, 08 Aug 2018 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x8d7zhah9vH3BSqL7uW6ia2RvOvTUmi4gB4k90PnssE=;
        b=unt0tACK/5EkMhI9NaNUM+UksmOW6NHegGQUR7J4SvVOwSVf70wtp/5hTMn1OLVIl3
         qVEikFziKS/XXtIqWr0qaVP7fHkla5vQSkpIDiCNp5zTv9lcNgmDlDaUIGR45yTUKbiN
         pURhiDOzHqtC/t3cs4/ayBFEk2ZNaxQi9C+3BZ7gZBUSIy0LYJdVqo034zAKtpI1yKQs
         3OtsCwkGCb6IpUcBcKiAXST2ZqNS0Ch7gzAbnAXbuITK4Txg/VCQd0b41RXlhSunycu/
         nBE4lfd1tn0BftbLdo6JTO20nb2x6kau1e+qWEkkLq1jtQRA7Zbc94B1SJMXiCAfaseb
         MneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8d7zhah9vH3BSqL7uW6ia2RvOvTUmi4gB4k90PnssE=;
        b=TcKZ8XesFZ1omautcP8CkUqkn9Idc8Kkfn27Q2ElFdyJGtp3U3dBOumSLN4ByURHfA
         3tmMXsuXupFmpmqIVRLZ4Er9vM0zW+yYGbHXqXgfATB9jdQejBBRnX2wu0rO51Zp1Pvl
         1SlwCgMmGcUS0XxvPH5HXlcSNul/0/T52OBTPU7/j6FHKEN+hHBan2t3FzkoD1rdUvZi
         9ukKOP+TMLLQlilMS4/7t3FgipPQTToxrvVhF4BJb+zrRg+QvXX+brr0k4Z0yc6i28s4
         atJyxS0Sv0r1vbJTI/u/ctW1qPTrCne7PFDDS2RA1aQbW0tnNaNrgQnuWQCWyMFeRNEd
         j68Q==
X-Gm-Message-State: AOUpUlFwug1chwrzPRfWT5MVHVpFrO045Q+m38h+pjvPY8Y/X7LcqeBx
        TKlhRF1eG4874JuGpV8xAp8=
X-Google-Smtp-Source: AA+uWPzj3Fvgi9uv6KVKIN3cjkhCfCsPdW0QTxLnm081UW/9PbHvmJCPcFHoXvjUd/rYmJ8JmCJXgQ==
X-Received: by 2002:a24:4254:: with SMTP id i81-v6mr2719864itb.95.1533746034135;
        Wed, 08 Aug 2018 09:33:54 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id k75-v6sm733347itk.31.2018.08.08.09.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 09:33:53 -0700 (PDT)
Subject: Re: [PATCH v6 8/9] net/mlx5: Do not call pcie_print_link_status()
To:     Tal Gilboa <talgi@mellanox.com>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-8-mr.nuke.me@gmail.com>
 <20180808060848.GQ13378@mtr-leonro.mtl.com>
 <05056a70-ee78-ea3c-0b9b-6d64a8663b11@mellanox.com>
 <20180808154142.GZ13378@mtr-leonro.mtl.com>
 <5578cd9a-e4f0-85ab-4a86-bfa23eec136c@mellanox.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <79264a38-e3e4-d270-95df-a09047f7a15e@gmail.com>
Date:   Wed, 8 Aug 2018 11:33:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5578cd9a-e4f0-85ab-4a86-bfa23eec136c@mellanox.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2018 10:56 AM, Tal Gilboa wrote:
> On 8/8/2018 6:41 PM, Leon Romanovsky wrote:
>> On Wed, Aug 08, 2018 at 05:23:12PM +0300, Tal Gilboa wrote:
>>> On 8/8/2018 9:08 AM, Leon Romanovsky wrote:
>>>> On Mon, Aug 06, 2018 at 06:25:42PM -0500, Alexandru Gagniuc wrote:
>>>>> This is now done by the PCI core to warn of sub-optimal bandwidth.
>>>>>
>>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>>> ---
>>>>>    drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
>>>>>    1 file changed, 4 deletions(-)
>>>>>
>>>>
>>>> Thanks,
>>>> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
>>>>
>>>
>>> Alex,
>>> I loaded mlx5 driver with and without these series. The report in 
>>> dmesg is
>>> now missing. From what I understood, the status should be reported at 
>>> least
>>> once, even if everything is in order.
>>
>> It is not what this series is doing and it removes prints completely if
>> fabric can deliver more than card is capable.
>>
>>> We need this functionality to stay.
>>
>> I'm not sure that you need this information in driver's dmesg output,
>> but most probably something globally visible and accessible per-pci
>> device.
> 
> Currently we have users that look for it. If we remove the dmesg print 
> we need this to be reported elsewhere. Adding it to sysfs for example 
> should be a valid solution for our case.

I think a stop-gap measure is to leave the pcie_print_link_status() call 
in drivers that really need it for whatever reason. Implementing a 
reliable reporting through sysfs might take some tinkering, and I don't 
think it's a sufficient reason to block the heart of this series -- 
being able to detect bottlenecks and link downtraining.

Alex

>>
>>>
>>> net-next (dmesg output for 07:00.0):
>>> [270498.625351] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
>>> [270498.632130] mlx5_core 0000:07:00.0: 63.008 Gb/s available PCIe 
>>> bandwidth
>>> (8 GT/s x8 link)
>>> [270499.169533] (0000:07:00.0): E-Switch: Total vports 9, per vport: max
>>> uc(1024) max mc(16384)
>>> [270499.182358] mlx5_core 0000:07:00.0: Port module event: module 0, 
>>> Cable
>>> plugged
>>>
>>> net-next + patches (dmesg output for 07:00.0):
>>> [  331.608472] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
>>> [  332.564938] (0000:07:00.0): E-Switch: Total vports 9, per vport: max
>>> uc(1024) max mc(16384)
>>> [  332.616271] mlx5_core 0000:07:00.0: Port module event: module 0, 
>>> Cable
>>> plugged
>>>
>>>
