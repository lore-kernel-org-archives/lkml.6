Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC3DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C7121736
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C7121736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeHCQw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732345AbeHCQw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8448818F6EE;
        Fri,  3 Aug 2018 14:55:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43D562026D65;
        Fri,  3 Aug 2018 14:55:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1533307535.4337.415.camel@linux.ibm.com>
References: <1533307535.4337.415.camel@linux.ibm.com> <20180723111432.26830-1-udit.agarwal@nxp.com> <8060.1533226481@warthog.procyon.org.uk> <1533297482.4337.373.camel@linux.ibm.com> <1533306238.4140.1.camel@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dhowells@redhat.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Udit Agarwal <udit.agarwal@nxp.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25966.1533308142.1@warthog.procyon.org.uk>
Date:   Fri, 03 Aug 2018 15:55:42 +0100
Message-ID: <25968.1533308142@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 14:55:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 14:55:45 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> wrote:

> "trusted" keys are currently being used to decrypt other keys (eg.
> encrypted, ecryptfs, ...).

Can it decrypt both symmetric and asymmetric keys?

David
