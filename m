Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3695C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2B924FEE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="u4bwMQ4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2B924FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeGBTRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:17:44 -0400
Received: from erza.pados.hu ([176.9.136.194]:58260 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbeGBTRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UVmIzZbXPBu1E6PpF6AIA5E5I7wVKIYnf+y0IsNNrdo=; b=u4bwMQ4C0UEiZODdGRjon0kQnW
        NXgM1nvIjEhAssSoW6ZODWe58l8k6M75X/bjhTfoJ7V++PdZiOiXpCiEMFd0vfkRwAIma7xJ8TYDm
        DGzw/jDvnYsE+DERUSWDQT2nkQbLhuWvu3Srj9/8tl2NbP6xvYBxkJewu+OpTTrKymErOjAkABgFy
        TR8SIBWlpqGhDzMRnGspzcjIP46b07deo5gH3XjJ633AyfA4IQGrt75Nk40BQE7qdbBFFu1pMHc8l
        +BHq2ynPhQAWvSwBWNqHtFcFgmao7BIWI7L+oVn5CMHQqeXodOJ7zIQOvoGT1Fo2rNfLigQkdx1DV
        RsTBqqLw==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fa4KN-0004eO-VO; Mon, 02 Jul 2018 21:17:36 +0200
MIME-Version: 1.0
Date:   Mon, 02 Jul 2018 19:17:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <f16a7de43b151c6f98ff5ff379427f16@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for
 CP2102N
To:     "=?utf-8?B?QmrDuHJuIE1vcms=?=" <bjorn@mork.no>,
        "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Martyn Welch" <martyn.welch@collabora.co.uk>
In-Reply-To: <87d0w5wm33.fsf@miraculix.mork.no>
References: <87d0w5wm33.fsf@miraculix.mork.no>
 <20180620082507.GO32411@localhost> <20180617182503.23080-1-pados@pados.hu>
 <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
 <20180620105231.GQ32411@localhost>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  >> First of all I can't seem to find that code snippet on
   the wiki page it >> does refer to, so I'm still not convinced. > > It was
   there in older versions of the article. See for example: > https://en.wikipedia.org/w/index.php?title=Fletcher's_checksum&oldid=730327006
    > >> Second, this should have been high-lighted in your submission somehow.
    > > Definitely. All code has an original author who deserves credit. And
   if > you cannot find the original author, then there is always a risk than
    > someone along the line stole the code... Maybe long before it ended up
   > in Wikipedia. But that doesn't matter. > > Doesn't seem worth the risk for
    a simple checksum algorithm which > probably has lots of GPL implementations.
    > [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: wikipedia.org]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> First of all I can't seem to find that code snippet on the wiki page i=
t=0A>> does refer to, so I'm still not convinced.=0A> =0A> It was there i=
n older versions of the article. See for example:=0A> https://en.wikipedi=
a.org/w/index.php?title=3DFletcher's_checksum&oldid=3D730327006=0A> =0A>>=
 Second, this should have been high-lighted in your submission somehow.=
=0A> =0A> Definitely. All code has an original author who deserves credit=
. And if=0A> you cannot find the original author, then there is always a =
risk than=0A> someone along the line stole the code... Maybe long before =
it ended up=0A> in Wikipedia. But that doesn't matter.=0A> =0A> Doesn't s=
eem worth the risk for a simple checksum algorithm which=0A> probably has=
 lots of GPL implementations.=0A> =0A=0ASorry about not explicitly mentio=
ning the source, I only cared about making=0Asure that there is no violat=
ion and I thought that'd be enough.=0ANext time something like this happe=
ns, I'll explicitly name the sources=0Aeven if the license does not requi=
re it.=0A=0AAnd just to clear things up further, rest assured that fletch=
er function was =0Athe only one copied from the Cypress knowledge base or=
 from anywhere else.=0ARest is by me, so there should be no other unclear=
 origins.=0A=0AOn a different note, v2 patches are coming soon with the f=
eedback from Johan=0Aincorporated. Did not forget and I still intend to p=
olish everything up=0Aas requested to get these features into mainline.=
=0A=0AKaroly
