Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F15EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257DD2152F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257DD2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbeHGUK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:10:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:22755 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733118AbeHGUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:10:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 10:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="73499433"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.170])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2018 10:54:56 -0700
Subject: Re: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
 <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
 <1533596748.3159.19.camel@HansenPartnership.com>
 <1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
 <1533602145.3159.23.camel@HansenPartnership.com>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tadeusz.struk@intel.com; prefer-encrypt=mutual; keydata=
 xsDiBEiLICMRBADteQacQxypsuFvAw6IwYzbD8pgQi+kLYBcqfGgVAUN/cO+sLl6u1lVdaDB
 fhAArdbV9lpoqcWnmhQFTb4A+W569EpydBr6nuatWkEB+fmmx8YoUtuZfXt7v+1l1rc09kaW
 LY+TkwQkvFCeuvdasgmBLnmRWymEGWi1E12hUgTw/wCgtK24geC7XkiuANMv0gpr+raOgQMD
 /2yJZ0SeXQApWyTRaeIYN8GgYHZTWuBp/ofN+viEkhrDxahcaGPP5B/Nv6VS1+M0e5m8OzHj
 qPUbgfyOeJcslC5aoZdqqqzVWVLaA/+Jy+O+6T3k3R/IryVVATldBlwnGFDhET0mKQsd15zt
 cIdQBBbfSFR5VlugZuWV5q442IpPA/4g7nen9FFPxh45Te8D54hAsOCywjm6xUE0UJGYHeJ/
 MXCPtuXfVCbYcOxZVH7kUS2Vtk5d3bF40IE2WnVq1ZScNANF4ZjikxYhYGfNWX3HXak1gSoj
 UrY87rMSjPIAry4L0BoIx2qgL/k4iV/3QcXL4t5wosU0iw++suf1zGGcKM0gVGFkZXVzeiBT
 dHJ1ayA8dHN0cnVrQGdtYWlsLmNvbT7CYwQTEQIAIwIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheABQJQTjJTAhkBAAoJEDFswfskq9xyqvcAoI2nsaUCX8ZGbu+Jhq+++qlBFJ2rAJ983RoO
 R2ofHhn3g3Qi4K34tw0l087BTQRauzUlARAAqkWRL/InEPnoGMg/gw/CRaDBaIBgMsvIcghI
 7xevIzpleXt6jKHghSBooH+zaT7qi4u2gkgPn4odsER3Rm94XgrZJgoqls6EpKMWpJNGP4HT
 eYgykhfsZOLX8ijUbjTM/Sm/dZVo6aYoBL2+ciJwyl+Zt3Mp6un3/GWu6cA9005V50pRqO7j
 PTlVCHi2bedcEEf5DDsYJv/3Oz8/4LpSf6BL6BltjeZVa2y03dTMmD031JTH+OuyJm1yh72Z
 HWxhlYNXOv6uFJJVr+paQjrAsBVIYKhK24bD+uGJxLm8AN9i7/Si+2YeSsXvKUhk9mIoFBnU
 VFo63cziRTcpRu/kXgDAbujwN88qytEcvhEZHS6B9vdws+lhTpolEjkLCkz0Y59z4Fs9srKy
 QkRN+wtdiLgrwyDW3ryAKxcDmOumGWebDxpaOI/pBhrlS93HmDlvj7JmgTUU4a/NhwI3dXh5
 pn8FZzZyVXe3Kc3bu5T3UAC7uztinsAvCJQS6jGZWrXmXkqYkaLXQOw61eInWjr01zE/zDbE
 mdJPM0+va/gtZx9TtGxr4PpjbqswqCiubLDZXZHh5uqArPv/i+E8aXIsNSTN6Rrqs1j9YgDN
 ALksibv6+tXH3sOlCUgjuZgJH3+s/mnaAtiV2rZ/WlH15d6nd0uiDSZrKhlR+g4NHMh1ztEA
 EQEAAcJPBBgRAgAPBQJauzUlAhsMBQkJZgGAAAoJEDFswfskq9xyfv8AoI8aPrJCoM0h5WOP
 kKxMmPEPHzUNAJ9jBBYXhX1CWg+IhI7i/fLlI0vwCA==
Message-ID: <7acd9a7e-4643-001d-a227-e7f80cdbf90f@intel.com>
Date:   Tue, 7 Aug 2018 10:54:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533602145.3159.23.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 05:35 PM, James Bottomley wrote:
> On Mon, 2018-08-06 at 17:09 -0700, Tadeusz Struk wrote:
>> On 08/06/2018 04:05 PM, James Bottomley wrote:
>>> For an async interface, shouldn't I be able to queue an
>>> arbitrary number of commands without blocking?
>>
>> That was the approach in the v1 version of this patch, but
>> Jason requested this to be changed so that only one command
>> at a time can be processed.
> 
> He did?  I don't remember that.  I think he told you the TPM itself can
> only process one operation at once so you didn't need an elaborate
> allocation scheme.

Right, but the allocation was needed only if more than one command
would be queued at a given time.

> 
> But anyway, if you're happy to limit the interface to block after one
> command is issued, how is it useful as an asynchronous interface?  I
> thought the whole argument for the patch was to avoid the producer-
> consumer approach which is possible with the current interface and to
> use a fully event driven polling interface which can be implemented
> single threaded.  If you can block in submission, this latter isn't
> really possible because your interface isn't really asynchronous.

Well it is. This change makes the interface non-blocking and adds a poll
interface. Application can submit a command in a non-blocking way, go
do something else and get a notification via poll mechanism when the
response is ready to consume. We could implement it in a way that more
commands can be queued at a time, but in this case there would need to
be limit on how many commands can be en-queued. Allowing to send many
commands without any limit could be harmful. So what would it be? 10? 50?
And what would happen if an application sends 10 commands only to find
out the the first has failed? The drive doesn't know about that as it
only copies buffers back and forth. There will need to be an interface
for the application to rollback all the enqueued commands and stat over.
Also what would be the use case for this? TPM is not a crypto accelerator
where one submits a batch of buffers for encryption. Usually the sequence
of commands requires that subsequent command needs to refer the result
from the previous one. For example first command creates a key and the
second does something with it passing a handle to the key created in step
one. Do you have any particular scenario in mind for multiple commands
in-flight?

Thanks,
-- 
Tadeusz
