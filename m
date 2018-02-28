Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3370786-1519798292-2-5953063456626016754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='koi8-r'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519798292; b=UJPCC9uTTDGnYqblXf62PG4zjarjXi7jlIvFfgpCH6bCGfS
    x3hficBQoEh5jKukzbdg/LlhN9b166GBlY63ER2UcqUIE7Q0NhTllVrokYgof8P3
    TehQeHXEQy9jLJdYinW5qofdcITiGxLiI+TxCVKq1wbziGrA1mhFyBvWXoi+K8Gk
    6l5lMxX+5ZPJZRryX9AmGLOmLSPUpMOgDld2UbvAaqGe6RMSj0Aqre5FGVHN4otd
    DEQXtQMRuTTzWCg55f7yw89LwhetiPZOSYReIMzmyXxfFgwoClVCoXfeZNtMSo1e
    HRBfR30gmzEG35tYSqakjsJxn4yLSeLpZWqG9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519798292; bh=aPOGkQ64VwvIcM7q9LcT805aex
    LSXS63Z0uZyyfwh/0=; b=Zi1HREVznH9KV3DZK16cqbNeVf6BXWzU1qMsElJh62
    DKiYjXbd0d3WqdnDYLeDvBO7n8mLCxmiMIOdm4dN3X68tKVv63YpYeE6LZetWrcp
    JRd+NFOkOw5abbRneV5VhOBW19N+sLBKX06m5zKPxcV6Sl6A/uFrh4OOhSZ3RadG
    eolGhTF9G3OlUZxz1s5S4/i5b1wvLSKgeKn04RcpiQAEnqFE98SFHM86wnUAuUR/
    i5LTEshGqrLoAPJze+3OH3CGSIZt+wQ0Ih5SacGtjmV66PU7it7nx2r0BXLfDuDi
    TDkGpcpUjOY9jzY49JOsXhwdh+Y8E+YyI691LnQfVQ1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=H2L6IZ7R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=H2L6IZ7R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeB1GL1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 01:11:27 -0500
Received: from mail-eopbgr50129.outbound.protection.outlook.com ([40.107.5.129]:38784
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751031AbeB1GLZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Feb 2018 01:11:25 -0500
Date: Tue, 27 Feb 2018 22:11:04 -0800
From: Andrei Vagin <avagin@virtuozzo.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, criu@openvz.org, gdb@sourceware.org,
        devel@lists.open-mpi.org, rr-dev@mozilla.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCH v5 0/4] vm: add a syscall to map a process memory into a
 pipe
Message-ID: <20180228061103.GA8608@outlook.office365.com>
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
 <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
 <20180227021818.GA31386@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180227021818.GA31386@altlinux.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: CY4PR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:903:77::25) To VI1PR08MB0750.eurprd08.prod.outlook.com
 (2a01:111:e400:5a04::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41853f8f-0115-49eb-f221-08d57e72154d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB0750;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB0750;3:3HGaLT9QBTCR5reCB5RJoTJ4HE++l8MKJratokfFNn1h3Qop+WVmUzuGZKGmfLae55edaaJBzxUEyYxSLAyjAKAcP9+89VxdiXKeBiW4wXcdEE9oJBA5j4N+DAhg/RkqnthJFrbsBAUCYKUAxTo/7lcsyhsfGKG6v4KPy+BvYgxcxDexTlURklgHKYEmVv5u/BsfXA6Gdc6jONFTwVqHuS+jnEdzPRrKgP8EUoCKL/gmN/d2O482lhMUegaxmQ3s;25:HKKGcg5OziI4vzoZwSx58k43V1P9WtTBqmNyvY4FTT9a230olzTTzFeDnr+GGav7APVsikRiCBzgZO0otnB578ov/xVTjYtLkHF1euB8s2FHw3omyvcWwkeYt4oUlCnNJXRl6OGEgychreYJMX+2QoXvLGRM1jr4c/S9tVwVqVxDDqlOqKUTozsfqUig7AqvDMal3elOK9ok9lICsVIOX818jhbgUaEEniBxmSYt8RT6M/KK92b54NNbBdQI+SW55OHBTUJsX2QEhEBi6uRnkMxiVlQXUt1BH+V+XJXWSPSsMKdsqCzxuDsHb8ksqGdOB1vEOHcWfumAarQffHs61w==;31:KQmGHSMn/WyFAyhdRwhIQ9zGb6hwy0PPPcj9IZ0bYh7EJcEuHBxibHdDU/hTbovl+Os7X/ZHjt9F3isGaj9+w5K8TeLkWbX2/Sq95zfYjwRGjbeQNen3okJWsiYNWn9++vEdLRK+b/bVqUXy7TvwyqtjugXnZnrQgCiNYpGbJ+Kp1E0rNEtyQ5o2yBsX2dHMKWk/ULx2uSOg/OJmtiNnmzDutavpMiD3aRETCE1T60s=
X-MS-TrafficTypeDiagnostic: VI1PR08MB0750:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB0750;20:YNAG/uMTSo3M5ccc6iEEtf+q1u+aeWXDgIPsHsK/8MsgcwgMWPWOsHkiK0tl3j7fR/JzyUExhRTPKSK4QBhewyKs4y7QmuAMMEZx7BzZGlq626+3pTHtTSoM0IAO00hsClUeoAx0283Twyw1QLvjP3xTEPiQ8yhZGuVqjyesJeWz7T5MbkN2xEZhT4jbzZr7E7YNu4A1p5lafHSo/TMNL+vH7DEiLXupIUwUrizf+T9oQ0CKukX5+qTTYQc5c8Aju6ZO/+sC5hhRU3ABQRmEIJ6PnxBCQ0X0wYTY/CoiGNq4eX5d3rE3YIz5Ja0wJLuhrC9BXJHNuEUjiTnmMj0fVGzJjiSIdztnF8CrYVNw97OEVbJ9Rkf7+E8baS4ltliVThuFMio0BlrNlJzsAkOIMzQPdekAQNarD3B3V1eefOiWqXoRxibsOTQHRfQkdJjGYzg1OiuV1kUBqMjYpLwirwamCW5YaJNgorhw+uXDzK287VtoXMDxf/Tjf4+kLSb/;4:Nm4xk/dtkZ7Qxh1z4DxS/G/8ozYIj8pfStbdO7m/E+S8pvsI3tGlPl793QyqGy8xiC+uMbXbTG/rv7aoOSElG0ACRfyqsVKNm1amoRhEVVvXjOrGaWAwvzC/2zB0qw/FXzAbigs0ZLBgzjpjEEpnki2+vH4Nt4e4uWcinGM1Llzuy1e00qVlALUmh5XA16n6kq2cVh/xV8TRpAOCnqWPWdlyqIOviVSXih6hojFX66AkXgNO6BrNpxcwBkPw3DvF3OOIPJkjEjPZs7jnjPskyskOiB//ZfTkV3OsuVZPLJhnAqAQUjl8maonDz2OD5OX
X-Microsoft-Antispam-PRVS: <VI1PR08MB0750EC79CB17CD098F11F533CFC70@VI1PR08MB0750.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231220)(944501215)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041288)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR08MB0750;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0750;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39850400004)(396003)(346002)(366004)(376002)(189003)(199004)(107886003)(106356001)(53416004)(47776003)(6916009)(186003)(16526019)(6346003)(16586007)(93886005)(86362001)(25786009)(8676002)(478600001)(2950100002)(6666003)(66066001)(81166006)(8936002)(81156014)(53546011)(52116002)(5660300001)(4326008)(54906003)(55016002)(6506007)(26005)(316002)(58126008)(76176011)(6246003)(386003)(59450400001)(305945005)(1076002)(69596002)(97736004)(7416002)(105586002)(7736002)(7696005)(39060400002)(68736007)(2906002)(9686003)(229853002)(33656002)(53936002)(50466002)(6116002)(23686003)(3846002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB0750;H:outlook.office365.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;VI1PR08MB0750;23:Bm9OHnQ2opku9QIk+GWZ5Fi/wLQzk1ARKk7g4xPkuuG?=
 =?koi8-r?Q?woJz7fGwK+6Iet9+vnQepSxxShYzyf6rgDIcp5tMn8X+HDboVWMMIcIzCXNEeR?=
 =?koi8-r?Q?K+r5DO9MvhGW9G9isJGGYEg2JOVCj0Fgz+WwyXbubBWxaxuW2bhl1HojjMZ26X?=
 =?koi8-r?Q?Q9bO+Po0cD/gc9KPMlgt5jzKyMboGIO410hAfe6+VmlVTujYClE0sgdOWdfXcU?=
 =?koi8-r?Q?VkfHm9E86+vtHWPjPvMOXTljVcElmykVcP8yxZui2XE5GUrtWpePSKbB9wB98R?=
 =?koi8-r?Q?Y0nt+x6ZhuXQ5dp6g7g7XEqK9WkNicRy3CGe2xoMYQFW0t7vsTlmzMQtYtehsA?=
 =?koi8-r?Q?TRJY6kaDuwGHk8ch1P+bzkwbWsaXirEG0jEwkmviX35XoKCzR/VXYljEIXywTF?=
 =?koi8-r?Q?sMN2i2dcDKIWnxmZBXZmolykVUhEu10mBFf4OslHkFEQ/WqQee0LbVMwDeNh7f?=
 =?koi8-r?Q?rNj9En9mJtDImqyM/8o+qrMCZl/M2A/OiTBEVYlH2MqAP5IC5Aqi+n4OGnkAzp?=
 =?koi8-r?Q?INw8UKoF7WOsoLeczerAoSETZiR0rPXvK/GLNJ3HwnqqAosc9dppihl+/9qbai?=
 =?koi8-r?Q?W8aCRGODZ86eEa8hJdz2wkjHPpaeBmT5eHgvKiMpQVSU6xNn3Yl+hv5D3EOZwL?=
 =?koi8-r?Q?fyfM07dBgJhPu44U/Ns6FD14f2a7Wp7vs129s2Jfnor86/sVyvIhvRrXyb/OFn?=
 =?koi8-r?Q?30KtcSvOz85bstsLPyABZ6K4ZSK2pg6En7Wta9ki9IZTNjPxdpw/kDqm6srQQP?=
 =?koi8-r?Q?TZNkcYezcegvjzaRsHsLYXEJiZizE2gLqg4K5J93vGkFoY809GeBwA8WxjiplR?=
 =?koi8-r?Q?Kom1tJ6vGR3+GVpxJMsaOLWqzyYKHsuY48uxNgAqJXO8f/2dMzllO0hC06hkqc?=
 =?koi8-r?Q?UVJKyiuybnmHJ1fe03ilrU+CfEyD88ronbVSnFa3ol229hfGg85WiGMkS+hNQe?=
 =?koi8-r?Q?q1l2O1o80tPcqn8qVqX49IixbU22mnuiOjWfB7KvLL5rzCAnLuHWJ1IN88RAaq?=
 =?koi8-r?Q?u+4kqg/+eZJjuLu+oiLxYlnLx3BeJtXSaoJJppwjbxW9X43lgC+ziZq3Ye2CQw?=
 =?koi8-r?Q?jS181IjxNtp/kzsTZUQepvorNEhchvPpMakd6IQvIdBt8Oge4hfiaJ67nScmB2?=
 =?koi8-r?Q?0kXS9+9kkyzPoqNN4oPnrVhZjxx4nIdKcR00/Xjz5daoHVH64fga4hIj0/ySrw?=
 =?koi8-r?Q?MNDdkgB3ya62k8rpYE2tbk16mSpDxqpIsGt6vf5o++1OBGGeJW8fG96sq0Kg/n?=
 =?koi8-r?Q?Q50XT5UnUtwsXqRIPBA9+XvJDB7o72IIWndxMlxZCK3dHpqAf3bkOev9Li6Rmu?=
 =?koi8-r?Q?ys8l3uR1xDL2u5rk14iAdtPHX0BfLZ4qy7eTVGsTp+xTsmXDgUhSKy2OAhoJoh?=
 =?koi8-r?Q?Y?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB0750;6:TilXhUu00Oat2meyDic7mOnmrkGlg0kUdzACRiKn3fO1FBLw3iuDsB0MpaprB6iwihyVX5ec+9UOKZlNYSt1pCZk6Y/N4wfxwZR52b6xOZ2MOEI1ShKu03JSX6k8zkU4U2AqYWyLC6h+QIJbZ7eRQ31UT9hAzvar20nSvThOu0uB2nA0n4IUlsm0t4kg7wM3+eURxSqQPRihrEAhTPBciJho3OcNWWhoc5kLe5JzcQ35wgzTdfJxwh+i1s5ddMbs6KAmkV9Rjn8VxWUYGQbXzdkRniu2hnHddtXGKSjJ1/GaNF5vRCeHWKWZJhV9lvQXmg/lHjCuXG2w0oJj/qWl9UEeM+5xtI9hIN5e+rotqOE=;5:yHc4VQS3dKISfSoD+NSLm9WaGj4eWxO7WjtNZN00e70rCJGGrfpR6HidvCwX0GkPZEYi/E1n5lWyEJ5gWoHSOiMScrJBhFoHvrhDgcO7paoUuqMdMl616uorOco1H2NHArXqxJOSBwNqGK2P8slB+UxOT+X1E0tA1hfBjP6PqPo=;24:wgpi5+MYVu2Uv6dS0v6S5JWGyrLPRFBmZm76BSO7/llVTMeB1NPhNca32SGd7J4qM74cayNAec+mCReDUME2xCK/wm95untLXTyynqvRH6s=;7:IThwLk5cTdqtSok1gKAISFCax6qSnLwpDhkglHHol+wR3hdhNr7e3KNZUlp8GyeqZaIyKybz/C6fv0teRnrYL8GN/u2ddzMwLIjDp3tcLUuURb/j5Kya1vxTz5qLXIggzOzL2/1gkFsQ4y8FmcYltK/WEBhqV1pDOzgAe4Ic0OK/LgAGEqmlVwWfnDRPZkyUm8phWliElyhz7Gu9ieTn5PU/b09n+XrkFhyzFP3S4KvW7/cgxsMX3vR/IonioLe6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB0750;20:cE/6R9n5gdVDXsEvI6tLAwhf4vD5RRvwqR+eNbFXdym0A7n5muzV2bgjvyo4mFCLCOi0N4ecsBa7n0T5icJrLyyJBBLDw/I1SNSLNFLZni2eG+8QFjoPG2sEcisJYjxMm/PgUj7HNU7ntxT6evbDr0QIuKexjspELV3MDy9ZGts=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 06:11:15.2062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41853f8f-0115-49eb-f221-08d57e72154d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0750
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 05:18:18AM +0300, Dmitry V. Levin wrote:
> On Mon, Feb 26, 2018 at 12:02:25PM +0300, Pavel Emelyanov wrote:
> > On 02/21/2018 03:44 AM, Andrew Morton wrote:
> > > On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > > 
> > >> This patches introduces new process_vmsplice system call that combines
> > >> functionality of process_vm_read and vmsplice.
> > > 
> > > All seems fairly strightforward.  The big question is: do we know that
> > > people will actually use this, and get sufficient value from it to
> > > justify its addition?
> > 
> > Yes, that's what bothers us a lot too :) I've tried to start with finding out if anyone 
> > used the sys_read/write_process_vm() calls, but failed :( Does anybody know how popular
> > these syscalls are?
> 
> Well, process_vm_readv itself is quite popular, it's used by debuggers nowadays,
> see e.g.
> $ strace -qq -esignal=none -eprocess_vm_readv strace -qq -o/dev/null cat /dev/null

For this case, there is no advantage from process_vmsplice().

But it can significantly optimize a process of generating a core file.
In this case, we need to read a process memory and save content into a
file. process_vmsplice() allows to do this more optimal than
process_vm_readv(), because it doesn't copy data into a userspace.

Here is a part of strace how gdb saves memory content into a core file:

10593 open("/proc/10193/mem", O_RDONLY|O_CLOEXEC) = 17
10593 pread64(17, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 1048576, 140009356111872) = 1048576
10593 close(17)                         = 0
10593 write(16, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 4096) = 4096
10593 write(16, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 1044480) = 1044480
10593 open("/proc/10193/mem", O_RDONLY|O_CLOEXEC) = 17
10593 pread64(17, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 1048576, 140009357160448) = 1048576
10593 close(17)                         = 0
10593 write(16, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 4096) = 4096
10593 write(16, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 1044480) = 1044480
10593 open("/proc/10193/mem", O_RDONLY|O_CLOEXEC) = 17
10593 pread64(17, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 1048576, 140009358209024) = 1048576
10593 close(17)                         = 0
10593 write(16, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 4096) = 4096
10593 write(16, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 1044480) = 1044480
10593 open("/proc/10193/mem", O_RDONLY|O_CLOEXEC) = 17
10593 pread64(17, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"..., 1048576, 140009359257600) = 1048576
10593 close(17)

It is strange that process_vm_readv() isn't used and that
/proc/10193/mem is opened many times.

BTW: "strace -fo strace-gdb.log gdb -p PID" doesn't work properly.

Thanks,
Andrei

> 
> 
> -- 
> ldv


