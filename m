Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2783972-1527008600-2-17647314406425402745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527008600; b=if4szmOQiOaXfncChpUBeqRVgWL9cAtSpxjAx9u32hfWYKYBD9
    r3o08GM2S2d7cQJIS+U6T7W6uyAJ1Sf2hA5IKwG9mOGKDQRzrPTAfHlDWD697t6n
    fdzIMy2EwEX37K+ieQiZ957PQo+ZUJG7h0NF9332bWsCWIhkB5efiaJ+VHsS3M6u
    BBEUAr7Y7XS5oiGW+QToTb8P7U9wYqZH+gVsgOy1f9g+tuiDLHGBIWJeoLvt3Nl1
    Jo7DaITKh3UyN3OJOiY7DSMLRfqsoriiZ4zmjXI0ixHGTaHorDoRnWCceSfDZnyX
    7PO526hwM3sIOjSffa6NYWPBLnV+4Qfyrl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:references:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :subject:sender:list-id; s=fm2; t=1527008600; bh=titjRa6F6Qg2/vE
    p81LmkHievT/Yf5Pq3nDcNQV6ICY=; b=b5fSdO21SyaLmE2dhg9zd+D3Hkg53J8
    moh8jYWhKra8AVnCnrMPD58sl/kQHWQb8MPGqKV83zOIOXaz0VTdDQBLgJSbipgT
    /OnO3UOi3dhQPvH5wyW2PvbJJTY3vMn//wEGTIqONrXBM7aln/Gw807V+bPZKNsA
    koDZgJBxAVuytFHLAn1RUFp6X72YXIpRZWufPky1JUcxzwUOedE/+MA6sh+Ga9hV
    5zD0nxGsLoJyuXJ136S5Q9llicmzf8WeKaHnlNwJYitV4CIzzqDAce0VEme6z4mX
    VpxYiZezFh/WMou0A520DygHoRQ7El5S87iZLSb6z/uy7qcODtPe+7Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deltatee.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=deltatee.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deltatee.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=deltatee.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLNaiQD49PdtyxQnWCSLw7x7IEF+tHQKzssfbFC8WVH8T6DtD3r3ozg6sRDcfBqPwLD6nO59m+EnWDdS+hc6bceu+Na4V0xt9uLGXrIhqFoSsuPNbFo0
    cRALJDUlRf92U0vUAku6F33/odBxRRLxz4DqiZr4muh9nouLpgnERjHXHISP28Yowpikeks8j63qoylnW+WrszN4wXAigmPNOes+/uYLiuDGruDoNcCXeBbb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=gXLdhW2jAAAA:8 a=YEnTv1jLUIbpEOKM2q0A:9 a=O5mxGlS8JZIt4RoV:21
    a=o1rLA4yNAcbj2VLT:21 a=QEXdDO2ut3YA:10 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeEVRDR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:03:17 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48342 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeEVRDR (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 13:03:17 -0400
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180521161026.709d5f2876e44f151da3d179@linux-foundation.org>
 <CAPcyv4hMwMefMu3La+hZvN6r+Q6_N5t+eOgGE0bqVou=Cjpfwg@mail.gmail.com>
 <860a8c46-5171-78ac-0255-ee1d21b16ce8@deltatee.com>
 <CAPcyv4i-MAYLsmT1M4=D_fwMNF98MupDyNBjWNmOzwY5Lzz0Lw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b636aa5e-205b-4d67-09f8-230755de31b6@deltatee.com>
Date: Tue, 22 May 2018 11:03:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i-MAYLsmT1M4=D_fwMNF98MupDyNBjWNmOzwY5Lzz0Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, hch@lst.de, stable@vger.kernel.org, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on ale.deltatee.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no version=3.4.1
Subject: Re: [PATCH 2/5] mm, devm_memremap_pages: handle errors allocating
 final devres action
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 22/05/18 10:56 AM, Dan Williams wrote:
> On Tue, May 22, 2018 at 9:42 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> Hey Dan,
>>
>> On 21/05/18 06:07 PM, Dan Williams wrote:
>>> Without this change we could fail to register the teardown of
>>> devm_memremap_pages(). The likelihood of hitting this failure is tiny
>>> as small memory allocations almost always succeed. However, the impact
>>> of the failure is large given any future reconfiguration, or
>>> disable/enable, of an nvdimm namespace will fail forever as subsequent
>>> calls to devm_memremap_pages() will fail to setup the pgmap_radix
>>> since there will be stale entries for the physical address range.
>>
>> Sorry, I don't follow this. The change only seems to prevent a warning
>> from occurring in this situation. Won't pgmap_radix_release() still be
>> called regardless of whether this patch is applied?
> 
> devm_add_action() does not call the release function,
> devm_add_action_or_reset() does.

Oh, yes. Thanks I see that now.

> Ah, true, good catch!
> 
> We should manually kill in the !registered case. I think this means we
> need to pass in the custom kill routine, because for the pmem driver
> it's blk_freeze_queue_start().

It may be cleaner to just have the caller call the specific kill
function if devm_memremap_pages fails... Though, I don't fully
understand how the nvdimm pmem driver cleans up the percpu counter.

Logan
