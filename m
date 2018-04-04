Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-322431-1522854895-2-6900757576567297044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522854895; b=maYRp979pyHVUQgDjbKVBqB7tP/VCtz6ExNGnR8aaw1KaQ+Cmy
    qLT6LyxFnu+NqKxL7G9WMChv9AtVbbgK1b6Ts4RaQD3l06JWmmZAsaxPl5nWE0hh
    3PxagMm8QB4aMng6rzWKXNr5+vIdSRSH8rFGfSpfRi2/xw6xbXtCqFSZuA9KhYLe
    nHuIA9FdHzbOrbEMYmcimM6B0iRgnSMtBhHdqMOJoYROo6sHSuKAF8tkjzBgqZSP
    b5W2edU2UmSzfT3otFGnmHqrZlWLuRiu4UT5dhhNxPufpm+rX2Gg5yCBlUVOvcyK
    rJOjP+54F7kvNOAov75Ec8oAuzJLDdmmUEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522854895;
    bh=91gCQd6ZuN4DAdOlDl7WUM5/qy0rUAaSwAqcfTxvLFE=; b=vAoHZwbS+pt3
    vTJohnVTizaTQo3ufUiBkLG/hOAtWlJaxui6nZRdgwrBU4CgLXtenOvTpQJzBa4Q
    xtnxH4eNdjHYIyt4qmrflNgogpyLrY5pz1OFlc0eYj/ntNB1UbnO25BMUqraSPW9
    c3a/yE7lBywCqp+8fzv5yusK8v4lGr+1FZcTfCotb9UfAN42UaDi4Ic1d7mlxppk
    EqvG89R3h2YsZMRopy+WhnEeqoaqnH/jUNBauaImh2Ne9eJ4QgCoKYzs2RhVyvg6
    J2ye9R880mG8ri0jqC4GkG6uCHvK4BJkzF7Axus2F6omWBcnaB6hX+qvhq0dAlFu
    ibR+tf/p0Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJFYVGBuFQ5FWJ9u71bDeLnaGbGIKD+cDBvIN/eT/c1yPeRUII4BgJR8Ctv3MC0GdKmYsFMDgok/jgpLQyILmFuqlRsgkh5k3P0DFkbhdzePL+Ro1vvQ
    eEWTvcR+32E+u/l6HeYmUcl+kDci/fqyk3dLyGs5uS/afc4X4f4cICDV41SIzNeXHfTYj7zPfPL4WSygghkR3ocHDKI8g+0VZnV/G+XqVY2n4L2TWbe4Gs/z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Q8gPAmPlUgYriE7O6PcA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeDDPOl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:14:41 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:53355 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeDDPOk (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 11:14:40 -0400
Subject: Re: [PATCH] usbip: vhc_hcd: prevent module being removed while device
 are attached
To: Oliver Neukum <oneukum@suse.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: valentina.manea.m@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180402205232.21659-1-shuahkh@osg.samsung.com>
 <20180403065618.GA1093@kroah.com>
 <6022b8f0-821a-2d1c-8032-4b298835feae@osg.samsung.com>
 <1522830330.30374.3.camel@suse.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <57af9443-7d2d-c3ff-3da6-0765ea0560f8@kernel.org>
Date: Wed, 4 Apr 2018 09:14:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522830330.30374.3.camel@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/04/2018 02:25 AM, Oliver Neukum wrote:
> Am Dienstag, den 03.04.2018, 09:56 -0600 schrieb Shuah Khan:
>> This is a virtual device associated to a real physical device on a different
>> system. My concern is that if the module gets removed accidentally then it
>> could disrupt access to the remote device. The remote nature of the device
>> with several players involved makes this scenario a bit more complex than
> 
> Hi,
> 
> you would doubtlessly lose connection to that device. Yet you would
> also lose connections if you down your network. You need to be root
> to unload a module. You could overwrite your root filesystems or flash
> your firmware. In general we cannot and don't try to protect root
> from such accidents.
> 

Yes. There are several scenarios that could disrupt access. There are
no bad things happening other than the expected read failures when the
device is actively in use.

thanks for the review.
-- Shuah
