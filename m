Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27F520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27F520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbeGTRRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:17:15 -0400
Received: from smtp2-2.goneo.de ([85.220.129.34]:50822 "EHLO smtp2-2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733198AbeGTRRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:17:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 241A323F3C4;
        Fri, 20 Jul 2018 18:28:11 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RSnng9x4hlVA; Fri, 20 Jul 2018 18:28:10 +0200 (CEST)
Received: from ryzen (dyndsl-091-248-138-213.ewe-ip-backbone.de [91.248.138.213])
        by smtp2.goneo.de (Postfix) with ESMTPSA id BA8ED23EFCC;
        Fri, 20 Jul 2018 18:28:09 +0200 (CEST)
Message-ID: <1cc801608a1e71b54fe97aae6f5ad2a0024e8e5d.camel@darmarit.de>
Subject: Re: Sphinx version dependencies?
From:   Markus Heiser <markus.heiser@darmarit.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Jul 2018 18:28:09 +0200
In-Reply-To: <20180720150402.GA32320@infradead.org>
References: <20180719181556.GA21435@thunk.org>
         <20180719190400.GB4800@magnolia>
         <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
         <20180720150402.GA32320@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 20.07.2018, 08:04 -0700 schrieb Christoph Hellwig:
> On Fri, Jul 20, 2018 at 09:30:33AM +0200, Markus Heiser wrote:
> > We have this discussion over and over again an I believe we will have it again
> > and again, as long as we do not change our POV .. building viewing formats is
> > an application not a part of the Kernel.
> 
> Sorry, but this is complete and utter bullshit.

Maybe .. I'am not a Kernel developer .. I only try to help with the doc tool-
chain. But if I don't want to install anything from the web, the plain text
is not as bad.

> 
> If that was the case we could skip all that RST stuff and just stick
> to text files.  If we want fancy docs it better behave like the rest
> of the kernel and just works.  python virtual environments are just
> not going to cut it as they lead to a long-term maintainance nightmare.

Really a nightmare? This is what I do on my ubuntu/debian box ... I do
prefer py3 so I installed *virtualenv-py3* once from distro's package
manager:

$ sudo apt install python3-virtualenv

To setup up a environment for building htmldocs:

$ python3 -m virtualenv py3env
$ ./py3env/bin/pip install -r ./Documentation/sphinx/requirements.txt

now I have all installed in the in the py3env folder. To build htmldocs
with:

 $ SPHINXBUILD=./py3env/bin/sphinx-build make htmldocs

If the env is no longer needed:

 $ rm -r py3env

 -- Markus --


> --
> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
