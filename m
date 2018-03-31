Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227338-1522478188-5-17895183919733214814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522478188; b=oHsTiGiP5Z3BsrWx9upTlJY8EHc8FRbpJf6n5oO9FV0vTfu5Ox
    mvDyTHGBfSjzCJp6ItafqwZ1RLm1kL/IRDmAhkuPIzE0roOKxFjzGhkL+IJ7Gp49
    Hv6ggGhzZRH+CbdE46WIE5bZWWrI8SjhCXnpsHTO0XPjJApYUVOcseIV4GE850px
    3I2FKlJu4/ryhpBOpHAZuIR8JTXpc7yBnbFR31y8tKhks+Ueg7EgNqGmG1kNUo8p
    xZVqG0pLVhzlFI4p3ujPrZX1y5iGEvigQuSdvics7jSDmfJc7QpTIvBiqwUUzZdw
    HxK8c3qD81kzH3Ke5lNxx0547liWXGeFLTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522478188; bh=h/6k+
    o2i5PtPCcE/lVveF225/QMPWXZWQ+KzcvNxEps=; b=NWuzhRaZKNgsIhf3VMeEt
    p2XPHulmJq0uvmXd7Zsipoiq5akJ/Xly//YwxIgPYcqlEYWJxy/q6uns0jqeXgow
    TZeqBqs5D22kbYvWmqZbn8smsaTUeLdTveMdlrIOaO62V/Bo5ZnCYh6Qgvi4xLu4
    qxKAVPuVHIlvF9whruY52LWjSeSgHnaViqe/ZRjtOT2pKzafBX+utjRvRKkcl/cZ
    u7VWMe/IngFbKb6QMYfLBH+0XY+AtKx3VIcQ9Dw3OZC7BLwsCdBzoCBArNI4qJsB
    8m+5FHeEEmwY9oSn6Ww5Ot43m4H2AasThnGYEAA3may5RjdcGl+ERDIWcdFLT8MA
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGtVjbkQg62HKOX62+SrSMLq9Z2gwcsv0OH4qy54oVEL5Dw1muTn+r8h7TqtGzIjVEiTBWKHl5t00tFeZcDG+csSRiHJ+bmQJc7q3+IRfvx9yMYD/MA/
    ipJBneNqlZkCRbBpIpt6vnHsuOgUWo3Gee1HW/VEWnwJNL+tdmPOI++P2u3hn4ohjjRuD1msFUdZ3AZGMLtp4TdcBxmxqWR0eJHZ2uHlt/Y0dmVvuBquOQfD
    t41VpFc+BALSJWH+oIdQog==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=6EION5jVRkTP5ZsF-d0A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::,
 RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4362:5007:6119:7903:8603:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13255:13311:13357:13439:14659:21080:21627:30054:30083:30091,
 0,
 RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:21,
 LUA_SUMMARY:none
X-HE-Tag: color96_1976d53fa3552
X-Filterd-Recvd-Size: 1433
Message-ID: <1522478173.2210.53.camel@perches.com>
Subject: Re: [PATCH v2 01/75] staging: ks7010: Use the ARRAY_SIZE() macro to
 calculate array sizes.
From: Joe Perches <joe@perches.com>
To: Quytelda Kahja <quytelda@tamalin.org>, gregkh@linuxfoundation.org,
 wsa@the-dreams.de
Date: Fri, 30 Mar 2018 23:36:13 -0700
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-30 at 23:07 -0700, Quytelda Kahja wrote:
> This macro, provided in 'linux/kernel.h', will calculate the size
> more succinctly than a division operation.

It's nice that you send patches, but please try to send a
cover letter with your patch series.

Also, 75 patches is quite a lot for a staging patch series.

Please try to send fewer patches in your series, say a
maximum of 20 or so and see what happens to those patches
before sending the next set.

Thanks.

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
