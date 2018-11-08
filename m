Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E470C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E978A20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VBr/7Xxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E978A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=whitewaterfoundry.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeKHOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:20:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56271 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeKHOUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 09:20:25 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2018 09:20:24 EST
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C27A21F21
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 23:39:27 -0500 (EST)
Received: from web4 ([10.202.2.214])
  by compute1.internal (MEProxy); Wed, 07 Nov 2018 23:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qUx6A4
        wm1jEZMm8UUaGTp02dAsUFOz8avM/S5cAAd9c=; b=VBr/7XxgS55Zay0RjD1mCo
        hmYGtHswT4Flu7kSNfCQS9v0Gb9NzpsyfcaGXQ0KjG9/Gg4/SSLle5fK5PWeIzbp
        dhfzlxMQixrFubPT15n9KNHa4Z5MUMC3HiFrvEduGFZqi9h3O1TWWlz+8TQlHw3T
        zU593U8sNN+4uzRydZIOzw12MaO62aaaHWLbUdeuMqXXUgXrvsTHJZq30q7GLOA2
        55Hlw/s4l5aQMMx+G7CWIPMiv6cHhTkHtaegESQuXjNfuNo3yncfMifgKZqj+hTM
        xB3YBdJBoAEO0Kd+rVFVFA4UDfL0+vaQxLZ1UoP/YoXxR2YsT2sjPERdzSBSmVEw
        ==
X-ME-Sender: <xms:_73jW6OrnpFNF0UYvwfYmcGVZ60pFJIyF8HNFL0P86VXwH7EzxsbxA>
X-ME-Proxy: <xmx:_73jW_FdZq4QCjz-heTJyLfr2zzsFkXA73hVV9KTajoXZ-TY5OrLIQ>
    <xmx:_73jW-mJ9tBBBHyUQ4gh45ao2GOJrdPETIj483lhenoZyIWww4oQOw>
    <xmx:_73jWzbq75Q0oOlPj7-Ttm5aVjx6zweI5nu9weX0frrbeqS1lsEinQ>
    <xmx:_73jWzGrCkMn9Jg2iz3W9mz4XCXU6uWeHCb_1c5Xp7eqZ0qCqyFE4Q>
    <xmx:_73jW0K-ObgiIRbJaVL3Il0ujcS2aEY68dGGUFt9t-sVqXPw9bYfaQ>
    <xmx:_73jWy67-atctcdEwM4LNXMHUY8srlPXnWe_wSu8WLLHp6uKSKKpvw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 0B052BA7C4; Wed,  7 Nov 2018 23:39:27 -0500 (EST)
Message-Id: <1541651966.672153.1569542472.2805F52F@webmail.messagingengine.com>
From:   Hayden Barnes <hayden@whitewaterfoundry.com>
To:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
Date:   Wed, 07 Nov 2018 20:39:26 -0800
Subject: Re: [QUESTION] Microsoft, WSL, and the Linux trademark
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Caputo,

Please allow me to address some of the concerns you raised.=20

The Linux trademark is owned by Linus Torvalds and administered by the Linu=
x Foundation through the Linux Mark Institute: https://www.linuxmark.org. T=
he Linux trademark can be used by third parties subject to a Sublicense Agr=
eement: https://www.linuxmark.org/programs/legal/trademark/sublicense-agree=
ment. The terms of the Sublicense Agreement permit the use of the Linux tra=
demark for derivative goods and services that deploy, document, facilitate =
the use of, or enhance Linux=C2=AD-based goods.

WLinux does contain a bootable Linux kernel in a base image.  The criticism=
 that 'WSL is not Linux' is because the kernel is not executed when the bas=
e image is installed and run from within the WSL layer on Windows 10. But W=
Linux can be used to patch and build the Linux kernel from sources to insta=
ll on other devices, assist in deploying and configuring Linux on other dev=
ices, and can cross-compile software using standard Linux libraries, all wh=
en running on WSL. For more about how WSL works for those unfamiliar: https=
://github.com/sirredbeard/Awesome-WSL#overview. WLinux unquestionably conta=
ins derivations of the Linux kernel, relies on the WSL re-implementation of=
 Linux kernel syscalls, and facilitates the use of and enhances Linux-based=
 goods, all within the terms of the Linux Sublicense Agreement.

We obtained a valid Sublicense Agreement for the use of the Linux trademark=
 from the Linux Foundation before launching WLinux. All of our intellectual=
 property compliance disclosures are here: https://github.com/WhitewaterFou=
ndry/WLinux/blob/master/LICENSE.md

Users who purchase WLinux from the Microsoft Store are supporting the Linux=
 ecosystem and free software generally. Everyone working on WLinux are Wind=
ows and Linux users who are committed to making the Linux software ecosyste=
m accessible to as many people as possible regardless of what device or ope=
rating system they are on. WLinux and WSL generally opens up new possibilit=
ies for bringing people to the Linux ecosystem, cross-platform development,=
 and expanding access to free software and free software development tools.=
=20

WLinux builds in a number of value-added enhancements and features, we prov=
ide end user support, and work with various developer communities and other=
 open source companies to try to make it easy to get into the Linux ecosyst=
em from Windows 10.  We make it easy to get up and running with Go, Ruby, o=
ther dev toolchains, soon Docker, install various editors, configure predic=
tive text input for non-Latin input, and implement a handful of other tweak=
s to defaults. I personally do not believe a frontend dev stepping into Lin=
ux should have to know how to partition and dual-boot a system, or even hav=
e to learn Docker, to get started using node.js and trying different packag=
es off npm. They will get to that.

Many WLinux users are going to end up working on traditional server Linux e=
ventually, if they don't already, as many of our users seem to work in hybr=
id environments as it is. I imagine a few will end up trying and then switc=
hing to desktop Linux, again if they don't use it already. But desktop Linu=
x is just one small part of Linux, WLinux is not here to replace it, and WS=
L is not capable of doing so in it's current limitations. Users are not bei=
ng 'tricked'. Free upstream distros from Canonical, Debian, SuSE, and Kali =
are available where you can implement our tweaks and custom packages manual=
ly. Of the many copies we have sold we have only had two refund requests wh=
ich we have promptly honored. Users always have the option of building WLin=
ux from source using instructions we provide. WLinux is also heavily discou=
nted or free in many less developed countries.

We turn the funds WLinux earns around to hire open source developers, spons=
or bug and feature bounties, donate to upstream projects, and cover overhea=
d. We are profitable and expect to pay out over $2,000 USD in bounties this=
 month alone after being on the store for just six weeks. We are focused on=
 building a sustainable commercial open source project that can direct our =
own development resources where we see fit to improve the Linux experience =
on WSL for us, the users of Linux on WSL. Microsoft has had absolutely zero=
 input into how we have evolved WLinux besides open source code of theirs w=
e have used.

Hayden Barnes
Whitewater Foundry, Ltd. Co.
hayden@whitewaterfoundry.com
https://www.whitewaterfoundry.com
https://twitter.com/WLinuxApp
https://github.com/sirredbeard
https://github.com/WhitewaterFoundry/WLinux

> In reading the news today, I stumbled across an article talking about a $=
20 "linux-based distro" app for Windows 10.
> This is just a bundled userspace for WSL, there is no actual Linux in thi=
s thing, yet the trademarked Linux name is used throughout.
> Did Microsoft license the trademark or something?  Did I miss a memo? Doe=
s their joining the Linux Foundation as a Platinum member two years ago inc=
lude such use of the trademark?=20
> I'm confused by what seems to be total silence about what _appears_ to be=
 an obvious large-scale trademark abuse in everything WSL-related.
> Could somebody informed please shed some light on this?
> The situation strikes me as harmful to the kernel as the majority of folk=
s being introduced to "Linux" this way will be tricked into thinking they'r=
e using/supporting Linux.
> Has the Linux Foundation deliberately turned a blind eye to this trademar=
k abuse because MS is throwing money at them or is it a formal licensing si=
tuation?  Do we, the community, even have any right to know what's going on?
