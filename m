Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209120-1525337191-2-12550869974779914802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525337190; b=RvFH+rPQey0h4vZeiBT3MVXKheUp7u5QsbtPniLyJ1EYE+3qMv
    UB44eEvdhxNadJs3AveGZMMcw0DGWJNynnSIizwY7PXA+GB3RO+jZi3QFfTn2Ybm
    XIVdvDtGjbvIvMzgHF3/EzyU6CyW5sLZPFgv85FOsmiaMp00a0hSXQpbjab0Yz1W
    qEjC5+8qwHWWuGsgYnxMgUrFQJBcoru4ruaOOXt2wq/5TGURyPnUmIGqzBOiOsgP
    qo1dAhB6r/UAyQg2O1jhTwqQ1USuwVZIFEqd6w38gG0hRKCgiPNtSKIEFdheU3Xl
    +Ty+8NQDQGJL5B1v7rSeVTnZDr/KyxMS2btA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1525337190; bh=Fad3mZBbG6/B
    +78o5s3f4ZYz3JthmZg1kj+MizDJ0kQ=; b=MXB0xAMqThdHar101xOsqn9TL7GN
    IfyaK1xtOptsePRTOLedUudLrZwMlVdhVftQumwZOTvL0JR7j+DQLyEPs2xfWNMt
    KEAryEseD8jMUPnL3kIuuhy07j6PSsbone0/M9ACwB9fqRw5qqLdm+fd3vxfdnJx
    EkXTGfbLcmIF4B2LNWTOa2QFMRe/1sESLV4m7NfqnTET+iq/uaIqCDxka+d3bOFg
    h+fTcDyBWLROgKG9RIdF5AyefAz1SdfuZKy52QoxbLQhEGOSp+xrNVvTTPoBb0nG
    F7Ii7lbzPfZjqJdYLnRJpr2LHvvdGW9XcHF6OGnRAtf8fBkT8+j9cg81bQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfONYEkXpmh+YT2xwRxEpGwdodG40egtJTFZ1Tm9HmSwIVWIU6iugOpc+zfmTQMnD0NIiSNO+4nvYWI/gcM+b8v7HTHm9kQGd1CvRc3azAKqxID4PdF92
    bJX4rHARKT9DpChcvKB7ERB9P8cqcF5SDA0I/SorECJwOWmyxI1Ks+0fhjGt0jGmlHCReSShelC6ekqXN5bDa5zfI3Rd6PuyeUdSvtYZyMQEhme/lXAu/eLD
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=N3JfWfJySTwAOt0f3cEA:9
    a=PiG6Isgd9udemFnC:21 a=K-Ee9RatkBGUXz9R:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeECIqQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 04:46:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751279AbeECIqN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 04:46:13 -0400
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To: Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 14:16:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18050308-0008-0000-0000-000004F27562
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050308-0009-0000-0000-00001E869A7C
Message-Id: <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030083
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/2018 03:58 AM, Dave Hansen wrote:
> On 05/02/2018 02:33 PM, Andrew Morton wrote:
>> On Tue,  1 May 2018 22:58:06 -0700 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
>>> For analysis purpose it is useful to have numa node information
>>> corresponding mapped address ranges of the process. Currently
>>> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
>>> allocated per VMA of the process. This is not useful if an user needs to
>>> determine which numa node the mapped pages are allocated from for a
>>> particular address range. It would have helped if the numa node information
>>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>>> exact numa node from where the pages have been allocated.
> 
> I'm finding myself a little lost in figuring out what this does.  Today,
> numa_maps might us that a 3-page VMA has 1 page from Node 0 and 2 pages
> from Node 1.  We group *entirely* by VMA:
> 
> 1000-4000 N0=1 N1=2
> 
> We don't want that.  We want to tell exactly where each node's memory is
> despite if they are in the same VMA, like this:
> 
> 1000-2000 N1=1
> 2000-3000 N0=1
> 3000-4000 N1=1

I am kind of wondering on a big memory system how many lines of output
we might have for a large (consuming lets say 80 % of system RAM) VMA
in interleave policy. Is not that a problem ?

