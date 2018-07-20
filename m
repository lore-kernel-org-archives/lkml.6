Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EFEECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8A120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8A120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbeGTRsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:48:11 -0400
Received: from smtp2-2.goneo.de ([85.220.129.34]:44034 "EHLO smtp2-2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387818AbeGTRsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:48:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 3859123F700;
        Fri, 20 Jul 2018 18:58:59 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vVMFz72boOdf; Fri, 20 Jul 2018 18:58:58 +0200 (CEST)
Received: from ryzen (dyndsl-091-248-138-213.ewe-ip-backbone.de [91.248.138.213])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 20A8323F498;
        Fri, 20 Jul 2018 18:58:58 +0200 (CEST)
Message-ID: <93aa59853a491a5ba3d5c3bcc0c991a1b815a67d.camel@darmarit.de>
Subject: Re: Sphinx version dependencies?
From:   Markus Heiser <markus.heiser@darmarit.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Jul 2018 18:58:57 +0200
In-Reply-To: <20180720164421.GG4800@magnolia>
References: <20180719181556.GA21435@thunk.org>
         <20180719190400.GB4800@magnolia>
         <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
         <20180720131206.GM30706@thunk.org>
         <d064f468ab9fc60a02242331e0dddc185d6556ba.camel@darmarit.de>
         <20180720145235.GA27862@thunk.org>
         <cd31ba58ac24851698e06628ceebce4648345ff6.camel@darmarit.de>
         <20180720164421.GG4800@magnolia>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 20.07.2018, 09:44 -0700 schrieb Darrick J. Wong:
> and now I'm just confused since 16.04 has the same version of docutils
> and an older sphinx and runs fine; but 18.04 has newer docutils and
> newer sphinx and runs fine.

Same here .. I'am completely confused by distros etc. .. I will never be able to
control that. Thats why I recommend the virtualenv workflow (as I wrote Christoph):

$ sudo apt install python3-virtualenv

To setup up a environment for building htmldocs:

$ python3 -m virtualenv py3env
$ ./py3env/bin/pip install -r ./Documentation/sphinx/requirements.txt

To build htmldocs with:

 $ SPHINXBUILD=./py3env/bin/sphinx-build make htmldocs

If the env is no longer needed:

 $ rm -r py3env

Am Freitag, den 20.07.2018, 09:44 -0700 schrieb Darrick J. Wong:
> Yes.  This makes writing broadly portable markup difficult -- originally
> I did not take the '=' all the way to the right edge of the table
> because I saw that last example in the above document and assumed that
> it wasn't necessary to extend the '=' all the way to the right edge.
> Neither Ubuntu system choked on it, so is this a bug in upstream?  Some
> strange patch added by the distro?  Something that ended up in the
> python wheel?  Or a bug in the spec?

I guess in the version history of docutils ;) .. use workflow above to escape
from distro chaos. Even missing '=' will be OK.

-- Markus --
