Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1041060-1520235928-2-10758812124310453817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520235927; b=mAn09L3nCGz/Y+2VkKT5TZB6sV20//pl/dF1mDcksTKKc9D
    3F/+BXwdl0mulQqyr8D2gLn+yggKPiLmliJ8aDXN1VV3RFNWf3TvM5vzWwotSBQg
    tNAOMBiPXFQQY4j3SYRk+HDpa4HYTKbPP5zT4I8//ctcWH7PNDN0iafRUYX1XHGu
    jB/jZy+zyV6L+WkLZLV5dEPqskMC5yJXT0k96kxNyds0LUTOLfSD4a0gtp2h/7wg
    c+6FQZiZablGtGxdAA2DKO1NlOszhK/a8JUKn6kqMqoMHrIixXtw0Ls8EQ6J/zBH
    EZNe1c9AqwDOkj4HWvPfStEE6dH9ILkaqGFDbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1520235927; bh=YGrcK7fL
    I9A5e29QATxZ22K25KK5uzFFOBNZvpqFBUc=; b=QEVEVvTM3xcns3x2jZ/HZ+kv
    6XdcH/vluVQxdJLNRFmYVfJ/WX7/4XEP5GHjyPdDhen6o0AB/vliPpBkFUhUvyAV
    t/9fH64DGIDC9KxgZacKUzhankCBeKq/jGVHQoBfA534TosWJZu2LzAgCF4DRXqq
    aWzCZscFznxcmyNowS+60/RBFWCyeLVfaHU6vZpl45bqUEA8Bzx0vb9M7+kkvJam
    5M6vgIj/CDqCC+jYUjHQu/Lx3KSYY4uitUda0L/TWBo17w1YhWwva8VnYhfKaL69
    pC261DqzkeVTfrzyIKK8MSAZOK4qwTzmbVPG8/ulyJwq4N+7f8uGHQcGl+XXDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=vhTh+Z5j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=vhTh+Z5j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeCEHpI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 02:45:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53362 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932723AbeCEHpG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 02:45:06 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180305074502euoutp026f5bd6de211c3a52c8172ae1e57215d9~Y9n-HylBe0146401464euoutp028
X-AuditID: cbfec7f4-6f9ff700000043e4-9d-5a9cf57d1029
Subject: Re: inconsistent lock state with usbnet/asix usb ethernet and xhci
To: Oliver Neukum <oneukum@suse.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <02679502-cf6e-8714-e879-50a922c5d976@samsung.com>
Date: Mon, 05 Mar 2018 08:45:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <1519747675.2649.3.camel@suse.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd3ar3OiDJouG1s836hvse/9WTaL
        y7vmsFnMOL+PyWLRslZmi2MLxCy6Hq9kc2D32DnrLrvH7q9NjB7rt1xl8fi8SS6AJYrLJiU1
        J7MstUjfLoErY8HOfsaCrWwVM449ZG1g7GDtYuTkkBAwkVj2eh5TFyMXh5DACkaJNScvs0I4
        nxklJp9YxghTtfrrPBaIxDJGib4bk9kgnOeMElu2/wWbJSzgLTFl0mKwKhGB34wS5/89ZgJJ
        MAtoSZz9epwFxGYTMJToetvFBmLzCthJdKxdyQxiswioSvzeeRionoNDVCBG4vUfN4gSQYkf
        k++BtXIK6EtMPtjBDjHSSuLZv1ZWCFteYvOat8wQtrhEc+tNsBskBPawSRxY2A31qIvEheVf
        oWxhiVfHt7BD2DISnR0HmSDseom+70eYIJp7GCX2tkyFSlhLHD5+EWobn8SkbdOZQQ6VEOCV
        6GgTgijxkDj2fzE7RNhR4lFnNiSA7jJJzD3WzjaBUW4Wkn9mIflhFpIfZiH5YQEjyypG8dTS
        4tz01GKjvNRyveLE3OLSvHS95PzcTYzAVHL63/EvOxh3/Uk6xCjAwajEw7sjb06UEGtiWXFl
        7iFGCQ5mJRHess9AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxxGnVRQgLpiSWp2ampBalFMFkm
        Dk6pBsYl9rPktp7+bnzduPBW44K/b9IfsHj63nzzxs9x3aPOc2UT9ypc77dbfGR1mU1l3xOD
        /UWbuzcvOCN9qLv9Tems5uxWxgfXviy6VH42qLhx/cqQue5zW/tLl8e5qz0Tli6PlzOY8aAg
        3PztNu+AbTqf1WxzmQzagra+Md3adpqd3+9xWPa+nxJKLMUZiYZazEXFiQAD1H9lIQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xy7q1X+dEGWz+K27xfKO+xb73Z9ks
        Lu+aw2Yx4/w+JotFy1qZLY4tELPoerySzYHdY+esu+weu782MXqs33KVxePzJrkAligum5TU
        nMyy1CJ9uwSujAU7+xkLtrJVzDj2kLWBsYO1i5GTQ0LARGL113ksXYxcHEICSxglnt76xAiS
        EBJ4ziix7L4QiC0s4C0xZdJisCIRgd+MEmcnnGAGSTALaEmc/Xocqvs+k8TZqTNYQBJsAoYS
        XW+72EBsXgE7iY61K8EaWARUJX7vPMwEYosKxEhM/biRFaJGUOLH5HtgvZwC+hKTD3awQyww
        k/jy8jArhC0vsXnNW6jF4hLNrTdZJjAKzELSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFec
        mFtcmpeul5yfu4kRGPDbjv3cvIPx0sbgQ4wCHIxKPLwChXOihFgTy4orcw8xSnAwK4nwln0G
        CvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl4uCUamB0lNq5de9R
        d6NJMbZFywJ1bDa9ZPVO2xuccuh+EOeHi6pPNm0IXZBW8MxO5rEX++EZm79KZhgcbtnV3bd1
        K9/XnA27Th2QY9kSrvSr6En7h3M3/F66zeZ9dqJ8dco7zgaNhqWPFsxjfX63cEl4eQVj55f8
        grcmR18UB7TLH9HefmFbhPD5+n+/lViKMxINtZiLihMB+qNbLXQCAAA=
X-CMS-MailID: 20180305074501eucas1p2493aa555486e53f4bca835c6568097ee
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd
X-RootMTR: 20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
        <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
        <1519740421.7296.6.camel@gmail.com>
        <bac44c1b-d701-2f6b-5e1e-738befc25c9d@samsung.com>
        <1519744167.7296.8.camel@gmail.com> <1519744400.7296.10.camel@gmail.com>
        <1519747675.2649.3.camel@suse.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Oliver,

On 2018-02-27 17:07, Oliver Neukum wrote:
> Am Dienstag, den 27.02.2018, 07:13 -0800 schrieb Eric Dumazet:
>> On Tue, 2018-02-27 at 07:09 -0800, Eric Dumazet wrote:
>>>
>>> Note that for this one, it seems we also could perform stats updates in
>>> BH context, since skb is queued via defer_bh()
>>>
>>> But simplicity wins I guess.
>> Thinking more about this, I am not sure we have any guarantee that TX
>> and RX can not run on multiple cpus.
>>
>> Using an unique syncp is not going to be safe, even if we make lockdep
>> happy enough with the local_irq save/restore.
> Unfortunately you are right. It is not guaranteed for some hardware.

Does it mean that the fix proposed by Eric is not the proper solution?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

