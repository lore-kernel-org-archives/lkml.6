Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAEAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA1720842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA1720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeIZTKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:10:31 -0400
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:7823 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726768AbeIZTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:10:31 -0400
X-EEMSG-check-008: 198452046|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2018 12:57:36 +0000
X-IronPort-AV: E=Sophos;i="5.54,306,1534809600"; 
   d="scan'208";a="18681975"
IronPort-PHdr: =?us-ascii?q?9a23=3AWElPzRLjFEfDaonAE9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvn/rarrMEGX3/hxlliBBdydt6obzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlKiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXfOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0kTZr2/fGPrvuApjWMHjDjK3tcq?=
 =?us-ascii?q?hg5E5B0AAz18xQ54pICrEdJ/L+QkvxtN3eDh8kPA242ujnCM5g2YwAR2KAHK?=
 =?us-ascii?q?uZPbjMsV+H+O0vOfOAZIwLtzbnLfgq+frugWU+mV8HcqmjxYEXZ2ygHvR6P0?=
 =?us-ascii?q?WZZmLhgtMAEWcMowo/Q/XmiF6cXj5JYXa9QaY86yolCIKpE4jDXJqhgL+f0y?=
 =?us-ascii?q?ehGJ1ZeGRGBkqLEXfyeIWOQ+0MZz6KIs99jjwEUqCsS4sg1RGoqQ/7xKNrLv?=
 =?us-ascii?q?HK9SIEqJLjztl15/HTlB0r8Dx0CNmS03yJT25qhW4IWTA2075loUBnyVeMz7?=
 =?us-ascii?q?J4g/pGGtxX/f9JVR06NZHExexgF9/yQh7BfsuOSFu+TNSpHzcxQck2w9MUeE?=
 =?us-ascii?q?ZwAM6igQrG3yqxHr8VkbOLCIYo/aLb2niib/p6nkrB0qZpvVkvRMQHYX+6ga?=
 =?us-ascii?q?hw3xbPQYPFjhPKubytcPEnwCPV9GqFhVGLtUVcXR84Bb7JRlgDd0DWqpL//U?=
 =?us-ascii?q?qEQLiwX+d0ejBdwNKPf/MZIubiik9LEbK6YozT?=
X-IPAS-Result: =?us-ascii?q?A2ByAADSgatb/wHyM5BaDgwBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?zUqgWSEHJRGUAEBBoEILYhpiQWGWzYBhEACg30hOBQBAwEBAQEBAQIBbCiCN?=
 =?us-ascii?q?SQBgl8BBSMPAQVBEAsOCgICJgICVwYNCAEBgl4/gXUNoxSBLoR3hSOBC4lwF?=
 =?us-ascii?q?3mBB4E5gmuHf4JXAp0HCZAnBheBN419K5Y/IYFVKwgCGAghD4MokBlWI4ErA?=
 =?us-ascii?q?QGMRgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Sep 2018 12:57:35 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QCvYNR027922;
        Wed, 26 Sep 2018 08:57:34 -0400
Subject: Re: Leaking path for search_binary_handler
To:     Tong Zhang <ztong@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, wenbo.s@samsung.com
References: <C2D9C687-4964-4DB3-AAF4-7C836324D6BE@vt.edu>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e36e7259-5cf8-3c5b-98d3-5c4d5c4b82b1@tycho.nsa.gov>
Date:   Wed, 26 Sep 2018 08:59:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <C2D9C687-4964-4DB3-AAF4-7C836324D6BE@vt.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 01:27 PM, Tong Zhang wrote:
> Kernel Version: 4.18.5
> 
> Problem Description:
> 
> search_binary_handler() should be called after setting bprm using prepare_binprm(),
> and in prepare_binprm(), there’s a LSM hook security_bprm_set_creds(),
> which can make a decision that binfmt cares.
> 
> We found a leaking path In fs/binfmt_misc.c:235, that don’t ask LSM’s decision.

Do you mean the MISC_FMT_CREDENTIALS case? That looks intentional to me, 
as noted in the comment there, and as per 
Documentation/admin-guide/binfmt-misc.rst's discussion of the 
credentials flag.
