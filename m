Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-364912-1525451312-2-9951839674187521487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525451312; b=Mdx4xG3f152tx0wVGf6YvoUuXbpmSRJpK2YPMpZUNuuPZRrCAU
    VPb/yVx+cw7eF4H0MSwTAr15xG3VsqdH+moZ9Tw/axUaRjEwnEeYAUw40vcm8MVE
    nBu2zqREIOnEgUQ21W0CUt61MsRhLOjhDAdw32RmPEy1vaAWdAiJzJkjN9UMdMfn
    9cv4Q9xZ4LRdTNVWvUeYiHH8rXLCR/mAoqvxciJMnzvE+HKeiBbbY2CM6KF9MOO8
    ziZKmyrgH/Cc+B6hQlCzEF0F7MoLrXiYTHLPKHI4lnfMpsAq1JdCFNF5pFAMRi30
    hRhfnO/hHdkq3zP+IOGJTVQFO1uFhzx3Nz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525451312;
    bh=3iGbrYM9uVfK8W3Fq9OWRiSmnURhBE0prGcov1OseVg=; b=kEitgF0kEyPS
    uEPHQWhgJ+hyC/k0sAqeruRMd5vR+IqvguR+OPFk9ZBhe6ZdbRFk79Ps3gPKtJgo
    7y234c7B/QuiOQZ+gZJp0dHyxNj52S9LXlOKLsy64VoCG1l7v/x56d7s5i0LudHU
    pN/NLxBWAYrBfqYvO8N4nMk/YPfq8mzGtzAyjKujhJLUzawdAMha6kGQ5lY7MfdP
    EWro30s3ep/LVvCE+rx4Q8vdNBaxSROR9kja7wPlmCf2G9NnFkfmkK4PFRIyFIme
    hVJ4mIn37WKxyWgyyJTuAxqut68y+egZj12E8qD12rsNf/IibgsaETLB1NRpczMR
    38unlGB5mQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=CiTvXpKB x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=CiTvXpKB x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLaOQ/vSV+Cdu7Ljzdkv60i98X8aAWIAXvUIUezHK5K0Fmt5f88o3LtmA844D/onom9oX7jcYcNjct4mYFjsXcX0bGWEE5rw9YUO5S+IeWsIs61wtN6j
    uOLyJHUI0rT33bW6JcqXpmmCh534e4zmGdby/TXx/jdTzBUTAk46L7ljOUHyTFMrAhcCM91x1SoDCKncClb1/TFZSDZN4rwlmoYv8dVpBDDRbCkpc89BqPV+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=aBfg-QOMA2m-Cb59uqwA:9 a=QOdM2GFKByV4LuyS:21
    a=dFpdumnS3Av_G0PV:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEDQ23 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 12:28:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33164 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeEDQ22 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 May 2018 12:28:28 -0400
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To: Christopher Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
 <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
 <alpine.DEB.2.21.1805040955550.10847@nuc-kabylake>
From: Prakash Sangappa <prakash.sangappa@oracle.com>
Message-ID: <98e34010-d55a-5f2d-7d98-cba424de2e74@oracle.com>
Date: Fri, 4 May 2018 09:27:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805040955550.10847@nuc-kabylake>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8883 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805040151
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/4/18 7:57 AM, Christopher Lameter wrote:
> On Thu, 3 May 2018, prakash.sangappa wrote:
>
>>>> exact numa node from where the pages have been allocated.
>>> Cant you write a small script that scans the information in numa_maps and
>>> then displays the total pages per NUMA node and then a list of which
>>> ranges have how many pages on a particular node?
>> Don't think we can determine which numa node a given user process
>> address range has pages from, based on the existing 'numa_maps' file.
> Well the information is contained in numa_maps I thought. What is missing?

Currently 'numa_maps' gives a list of numa nodes, memory is allocated per
VMA.
Ex. we get something like from numa_maps.

04000  N0=1,N2=2 kernelpagesize_KB=4

First is the start address of a VMA. This VMA could be much larger then 
3 4k pages.
It does not say which address in the VMA has the pages mapped.

>
>>>> reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
>>> So a prime motivator here is security restricted access to numa_maps?
>> No it is the opposite. A regular user should be able to determine
>> numa node information.
> That used to be the case until changes were made to the permissions for
> reading numa_maps.
>

