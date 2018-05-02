Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1424822-1525300144-2-9966539818620243975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525300144; b=YAGE1e9uONqkKbJj7TBLVY06XY9U2BE04shXGOyo0aqR+kUW4R
    Ott4zptiBfMmtTNBG7awuBdcX5sSFAabpXR+56dDqku2LYMu0AI3nVg+OYuggOAK
    ob71TtzMVRNcs+Q/x+odydNnAhozmZTnNT40dhEQTtRXszE+VudNxzSA1a1yYiEX
    f5ml2nZqTl0jsN/iqk2NbG9gvp5rZwsN0jfGhpr3grXUeWjf6Wj48yk1B/ueF1ek
    h0ZNwDWqYR9gvPDZv+/3zu+zwdZk3uncVldUpOuEBPMOmV36EtU9SCiwgTmFmFrQ
    4a1dgUr+8Gk1Bp6vcbjmMtJAkq5SGP9U3UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525300144;
    bh=grkJ1qBnFjrjBKV6zejF/WsalTr4N6qwi45fOpRZ00Q=; b=MIJOvDlG3/4G
    1LtlI3Y8HuncPueQPCMd9x+lw9N8lk6LNfUIybzxXW7n0T1aQBx2UpGKLHgHts6Q
    DOnCtk+rqCopn43M3WJaAx+NB8llV5+7vA9X+4RAzl7EoZRSlYEyXy1/8ty9JOJG
    Xy1WUC2AshuVG0MlTn73OZzdsPYJ2K4/U5rD4EqA6aGakmgOpEHff5lIBD95lpCw
    ncdOU++QpctN20Qxcv0+W1/3XdNuCUCQ0CFqeEdCqrsJP0BEGQr22ufNUvAeuS9Z
    z1mA5AW93bTINyMLMKV0Ey+UdPGlOpKroJkmv+cbxJeRDn9JvWIVqOrt1EsX5CfB
    61RnTz6Ttg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMNuqSCewQFPuDFGdgmgUW8KYGIliSIrA6grEP0dEjJNaoeUj3hhoox9pLUwi+4hnVKWB7yEQslP2XPlgc73EqSWyQPWzc5ha8ydnk4maMS/RIo1gagt
    Ys6HqtOKVVrT4vSdsAa/v8L2hKNo+mSSWIMe08U1gLXfWtoqyO/OW6gdeqm5QrH332kQPbceKwjtajLfbIS3hHiLKgRso7TNnkVeSMcMMt6Arw486JrDFnYN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=QHC2kOqy_hB1d3D8XDEA:9
    a=dnDLYe6u3gwoinPY:21 a=wbSfyBzsI5RBps27:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeEBW3B (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 18:29:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:46566 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751261AbeEBW3B (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 May 2018 18:29:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="221149976"
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To: Andrew Morton <akpm@linux-foundation.org>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
Date: Wed, 2 May 2018 15:28:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/02/2018 02:33 PM, Andrew Morton wrote:
> On Tue,  1 May 2018 22:58:06 -0700 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
>> For analysis purpose it is useful to have numa node information
>> corresponding mapped address ranges of the process. Currently
>> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
>> allocated per VMA of the process. This is not useful if an user needs to
>> determine which numa node the mapped pages are allocated from for a
>> particular address range. It would have helped if the numa node information
>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>> exact numa node from where the pages have been allocated.

I'm finding myself a little lost in figuring out what this does.  Today,
numa_maps might us that a 3-page VMA has 1 page from Node 0 and 2 pages
from Node 1.  We group *entirely* by VMA:

1000-4000 N0=1 N1=2

We don't want that.  We want to tell exactly where each node's memory is
despite if they are in the same VMA, like this:

1000-2000 N1=1
2000-3000 N0=1
3000-4000 N1=1

So that no line of output ever has more than one node's memory.  It
*appears* in this new file as if each contiguous range of memory from a
given node has its own VMA.  Right?

This sounds interesting, but I've never found myself wanting this
information a single time that I can recall.  I'd love to hear more.

Is this for debugging?  Are apps actually going to *parse* this file?

How hard did you try to share code with numa_maps?  Are you sure we
can't just replace numa_maps?  VMAs are a kernel-internal thing and we
never promised to represent them 1:1 in our ABI.

Are we going to continue creating new files in /proc every time a tiny
new niche pops up? :)
