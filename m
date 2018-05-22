Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389970-1526987633-2-15268041683768691638
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526987633; b=kSjfZxWGIBlxaIQgTSlkDh6nF/yfhYvWBLXdgHY4s9D+YaJyvi
    tNaVXeqochYvxPKGqsJMjfmEETVO1GETV/9zT2aNalEBYTnaWFjwY1Jp5+6BEB/b
    +G/FKsNBtPH1x/Q3GBKz0TMw58Acm0OTcgvruipohy6POj8AtD5QCvfFXzybXMdz
    8izW6xciVimVmXwL3FQ8BDM8qrRtRJE1uUnrjOWBKJY/rx3tnKka5tpT+IY/eUbP
    nHYnq/Uw7QUIjyOY2a6U5viCYtvndZ9MDNNQHiMmBBjqKTOBLLck1QkTTZGPiWDO
    1KiqgR60PE02f7un8NzuQpErqcG9GGlyp7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526987633;
    bh=SQC28kmHtSyepdYm5QxfqJdGKT7BcmwxIgKFVKt5jSU=; b=dh0wW7eBJhfo
    WwYgr6jmyIH7FeJyt5r+OHPz1LALjOaNrxI7wlxaIexOk4MVFO7Olw562ufFAUlG
    ztVRDIr4lURb4eDocGwqWWXeR7RCJuSoog972BzVnCVSSv/tQHxEdr28LkSFA9PO
    lgI/D1jydb3ytqJd7K4fD6pu5FKsmu3AZkqj9OMHub9zMRTRiEKEZ6vcNpJX0n1R
    nTj13wSzHQU7R/nc0dVnhIYoYt4K5rS24WLkHqDf50qMZAAfZ4avxXZTCLe+n8ZJ
    ghhBublT2+xugJEWo3+3P/EPXiCJZPcwm8wWgBBzrJ6mQ2teMJB+YICLp0ktq03L
    PWQLBRB3ag==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD6R0lGTNrgMf3fC2Jlg8c0EK/7eL1grR+UosDOFWCVNmAD2GDOngGDkU2F/5od9o/oVg2uvCdli2eIuIJNesLrdJuNTgZocS2DXnq/hLlbJtbgyP24u
    kR265H+An4rg/gJGH2ctXS96X5maONZWTMjQUG61RQzsO/7EAmCcpgmjuN4nAM3nNnuOW329KvHdswJuAWOuI0v6bh7ReRWHigvOLI3/cRUNK0FDcaM/GgSe
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=MyVaHAqUCHEA:10 a=N659UExz7-8A:10
    a=VUJBJC2UJ8kA:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=Zt5R5_gIepOIDh1y4hUA:9
    a=pILNOxqGKmIA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeEVLNj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:13:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44259 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750733AbeEVLNj (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 22 May 2018 07:13:39 -0400
Subject: Re: [PATCH 01/33] usb: phy: use match_string() helper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-2-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Ven5JXiaPA50K_fq33L2W+atHT81Txp3D=6j4Op1BHPGA@mail.gmail.com>
 <20180522100208.GC11079@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <6bc1152f-198f-4b73-d3b8-2bde7d83de71@huawei.com>
Date: Tue, 22 May 2018 19:12:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180522100208.GC11079@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 2018/5/22 18:02, Greg Kroah-Hartman wrote:
> On Tue, May 22, 2018 at 01:20:01AM +0300, Andy Shevchenko wrote:
>> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>>> match_string() returns the index of an array for a matching string,
>>> which can be used intead of open coded variant.
>>
>>> -       int err, i;
>>> +       int ret;
>>
>> int err;
>>
>> would still work.
> 
> And it reduces churn.

I will keep it as err in next version.

Thanks
Yisheng
> 
> 

