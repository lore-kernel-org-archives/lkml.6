Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1449009-1527770456-2-14189681734200723787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527770455; b=UXMgpqzZWblV/xs5Qvsrw9UIKlpCaS52av608MQ5aw7a3XbJjf
    fsDS9gjjvVK3xO5JWUuuacwG4gVBgwF3WS/H3OTt6mQ82Ks6VSSF8iLlxvR8p8qC
    7cBXYOXqHwn0OrsKECUt0nKOCw4YztalxzuOMTu5VbDipZGoMBRLSbWao5gcMPnG
    7Wk5dWsa4swy6u3DSMcqsVOzHs8+E18FhK0TPuYdbn5n3FO0XgeM7P3mkZemOaWc
    6lEkITo2+G/7o6TXe9730BLJZqjKpTWZtygLVw3MVHEOxsJLRJOtexip5jUMJjda
    m1q/mhRoGIV5OjEkob6IcgGDKDJ3Y0CK/Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527770455;
    bh=8t51ao0YTYpF/8bh1ewu0rn9Qg5Od/T49wADw170eUU=; b=NQA7hw47JQ3n
    B88lGDSyEDk0COl3K5ikdidxWc/taRmdtZPsU4cTSe8q+W1p5no4iX92jKYRbLxJ
    gs1tJGyJZtpunPgwrX6kkeppYVKng4OAaMh7zd+qyoIO3CxPlXKVLrZttKAz0p/H
    bqDP7dYwCpjyj3mmkagDLZ8DNFJOubkA8WxAeE9Od+8BzazDR4J7jIZsUMiRfZCv
    qj+1od5w3YpPZ8kJUp+i3yX9Oz3MB4/pdSjQCzDbwquMOgGW4LAWN/Ud9gcAkxT0
    ZAJwBLAnhyXV6nVDcwhnnK2RvFPZEaeXpM/B7BiHV+5xawYZZTD9QU8ozZEQ+5Ry
    QOVFD/yJHw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=tycho.nsa.gov header.result=pass
    header_org.domain=nsa.gov header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-110 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=tycho.nsa.gov header.result=pass
      header_org.domain=nsa.gov header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-110 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMNG5FDjHj/kT2TZWbd4rOdAliOUALncCKS/rhzDm2y5JvWsI6f8igGnnSgV11rMsfcu12Su9am1Wb9gyK46cgwbbARaVpGsXYBXgjSJaUMHj+VhV1S6
    Y9/0x6fb5GhIaoCdXAiWfRmO4011HvxNsxuubIG1uKINd4qPgSTjC4DPqWUmeK+Dmhq1vJm3kzJU2gfM6al17mgOcpEhRWuUkydSzKZeDHuc39QGB7hDq2p7
    bEydKS0+kDtk2q7MBx2oJg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=YMoOU55_PVpsFRh4C0wA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeEaMkx (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 08:40:53 -0400
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:57231 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754197AbeEaMkw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 08:40:52 -0400
X-IronPort-AV: E=Sophos;i="5.49,463,1520899200";
   d="scan'208";a="12333147"
IronPort-PHdr: =?us-ascii?q?9a23=3AxVU5vBXBgngMGZ8Ya0AKxaEEIC/V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZROEtKdThVPEFb/W9+hDw7KP9fy4BCpYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLBi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoRS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJqXhDYvRLnfdirftZ6?=
 =?us-ascii?q?hy60hBxwUt19BQ/JVUCqsOIP/oQU/xs9rYDx8jPwOoxObnDc131pkCVmKXHq?=
 =?us-ascii?q?+ZLKTSvEeQ5u01PumMYJQYuC7nJPg44/7ilHo5mVgafamzw5Qbcmy3HvNjI0?=
 =?us-ascii?q?+Be3rjns8BEXsWvgo5VOHllkWCXiRJZ3azRKIx/Sk7B5i8DYfCXYCtmLiB0z?=
 =?us-ascii?q?2nEZJIfGxGDUqMEXjwfYWeR/gMcD6SItNmkjEcV7iuUYoh2g+1tAPgz7prNO?=
 =?us-ascii?q?/U+ioCtZL51dh1/PbelRYo9TNuE8ud13+CQ3tokWMPQj88xLp/rlBlylefza?=
 =?us-ascii?q?h4hORVGsFJ6PNPUwc1K5rcz+5hBtD3RA3BetOJR0ygQtWhDjA9VM4+w9gLY0?=
 =?us-ascii?q?xlAdWtkgjD3za2A78Sj7GEGZg0/bzB0Hj/IMZ90WvJ2bI7j1Y4X8RPNXephr?=
 =?us-ascii?q?Jl+wfPAI7Jll2Tl7y2eqQEwC7N6GCDwHKKvEFZVg5wTKrEUWkEZkTIsdv5+1?=
 =?us-ascii?q?nCT76yCbUnKwdBzMmCJbZXat3tk1pLX+njONvAbGKrgWuwBgiHxqmKbIX0f2?=
 =?us-ascii?q?URxiLdCFILkwoL53aJKRA+Bju9o2LZFDFuEVPvY0Xx8ehxsX+7TVE7zxuMb0?=
 =?us-ascii?q?J/07q44QAVhfOCRPMJxL4Euzkuqy9yHFmj29LaEd2ApxBufK9Ee9My/E9H1X?=
 =?us-ascii?q?7Ftwx6JpGgNL5thkQRcwtppE7u1w94CoFEkckqqnMm1hZ9KaWd0FlZbTOXwY?=
 =?us-ascii?q?jwOqHLKmn15B2vc7TZ2kza0NaT5qgP6+81q1HivAGvC0oj/G9r08dT03SC+p?=
 =?us-ascii?q?XGFgsSXon0Ukot6xd6oLTaMWEB4NbM2GFhK+G5tDPPwdguHuRtng6tY9pFdq?=
 =?us-ascii?q?6CGALoGcoACOC1L+o73VOua0RAdNhb6ap8GsShbfbOjLaiIeJIhDu7iSFC54?=
 =?us-ascii?q?dn3wSH8C8qDqblxZcOi8mRxAqcH2PxlF67s9vfgYleZCoKGmO0xG7jHoEHIu?=
 =?us-ascii?q?VQdIMGEi+LJNetx84205zkXnNDslrlAlQcws6yUR2IZlf50Etb0kFB5TSLkC?=
 =?us-ascii?q?25wjg8sSwzoaeZx2Saz+3kdRcDOEZOSW1mhFHrMc6/iNVMGACEaBUm3D+o6U?=
 =?us-ascii?q?j93aQT8Kh7ImXdRl1EVzL7I2FrTu27sb/UJ4ZU5ZcptzhHePitalCdDLjmql?=
 =?us-ascii?q?0V1D2nV29fwi0rMiqnsYjjngBrzWeaIGt3oVLHdsxqgxTS/trRQbhWxDVCDC?=
 =?us-ascii?q?15jyTHQ1uxJd+k+f2KmJrZ9OOzTWSsUttUayavhcm7uTG06CVHSVv3v/m3ns?=
 =?us-ascii?q?zhW0BuyiLh2NRCVSzMqAf6JILs0vL+eahfd1RsTHK0rYJfEaJzlI09ldtYjW?=
 =?us-ascii?q?ATm5GQ9nkvlWb1LMUdx6TzcDwMTztNyNnQtlvLwkpme0mVypr5W3PV+c5oY9?=
 =?us-ascii?q?23cytCwS4mx9xbA6eTqrpflG16pUTu/lGZWuR0gjpIkahm03Udmexc/VN3li?=
 =?us-ascii?q?g=3D?=
X-IPAS-Result: =?us-ascii?q?A2AMAwD/6w9b/wHyM5BcGgEBAQEBAgEBAQEIAQEBAYMZK?=
 =?us-ascii?q?2J/hB+UZkUBAQEBAQEGfwghgQ+TUIFkNgGEQAKCBCE4FAECAQEBAQEBAgFrK?=
 =?us-ascii?q?II1JAGCTwEFIw8BVgsYAgImAgJXBgEMCAEBgl5AAoFyDaZzghyDeAEBXoNsg?=
 =?us-ascii?q?WiBCoc1gQyBB4EPJAyCXYQ3gzyCVAKYaAmOWgaBPIZXhH8rhy6LFCGBUisIA?=
 =?us-ascii?q?hgIIQ+Cf4IfF41hAVEjgSoBAYxGKoIdAQE?=
Subject: Re: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable
 holds
To: peter enderborg <peter.enderborg@sony.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
 <8bbb095e-31c3-0062-d17c-662e4832cc17@tycho.nsa.gov>
 <1cf240b9-57ee-eee3-228f-5ad4a3a39e57@sony.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9332801c-6102-2486-ab60-b48bb38ae207@tycho.nsa.gov>
Date: Thu, 31 May 2018 08:42:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1cf240b9-57ee-eee3-228f-5ad4a3a39e57@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/31/2018 05:04 AM, peter enderborg wrote:
> On 05/30/2018 10:34 PM, Stephen Smalley wrote:
>> On 05/30/2018 10:10 AM, Peter Enderborg wrote:
>>> The boolean change becomes a lot more heavy with this patch,
>>> but it is a very rare usage in compare with read only operations.
>>> The lock held during a policydb_copy is about 1ms on a XEON.
>> This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
>> That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
>> In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?
> That one did not make it, so I went for a other path. Make it simple, using the same serialisation that exist. That also make it easier to maintain.
> We do not  use the booleans in android since they are not allowed so im not aware of any use case where this administrative function are
> used in such frequent manner that it would have an impact. And it must be some other large overhead with interprocess communication and
> a multiple writes to sysfs during a boolean settings?  However my concern is/was memory pressure, setting booleans will generate pressure
> with lot of atomic allocation and large vmallocs.

Yes, that is also a concern.  I would prefer to only duplicate the conditional policydb state as in KaiGai's patch.
Keeping temporary setting of booleans lightweight is desirable for other use cases than Android.

I'm also concerned by the implications of switching all of the allocations to atomic.  KaiGai's patch did not take that approach either, and it obviously could make policy reload more prone to transient failures.

 But my goal is the fast path for real time critical functions such as audio, and it will be a cost for
> administrative tasks. On the xeon it takes about ~98 ms to run the security_set_bools compared to about ~8 ms without the overhead
> of copying the policydb.  About ~6 ms is rcu sync and ~8 ms is the same as the original update of selinux statuses, and about ~25 ms
> is policydb_destroy() of the old copy.
>>



