Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B75CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A51420824
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A51420824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJ3MGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:06:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:58533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeJ3MGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:06:47 -0400
Received: from homer.simpson.net ([188.174.240.89]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1fmRdp14Vc-00mbld; Tue, 30
 Oct 2018 04:14:57 +0100
Received: from homer.simpson.net ([188.174.240.89]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1fmRdp14Vc-00mbld; Tue, 30
 Oct 2018 04:14:57 +0100
Message-ID: <1540869294.4811.3.camel@gmx.de>
Subject: Re: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
From:   Mike Galbraith <efault@gmx.de>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Date:   Tue, 30 Oct 2018 04:14:54 +0100
In-Reply-To: <20181029214913.GB13325@tower.DHCP.thefacebook.com>
References: <1540792855.22373.34.camel@gmx.de>
         <20181029132035.GI32673@dhcp22.suse.cz> <1540830938.10478.4.camel@gmx.de>
         <20181029185412.GA15760@tower.DHCP.thefacebook.com>
         <1540846014.4434.10.camel@gmx.de>
         <20181029214913.GB13325@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:o30deUKRYYaM49eWFedlIjFiWSLjWyOIddhHEQ75ns3QKBpYp69
 UNMuMJI2gYonq9V0aVTlND1nKG3M0pOxgwDQdmlr0sts4iqVrUxeDAc5FJg8HpwP5Z/V4Gj
 IBCx5VQoLzkBeXHcseq2nNiweIAU6iaVAEl2fkqJg+7lqHI8XXfZqEckAgT0c9tUE/inIAZ
 PNSZfO6nU5mmy/ayTPfQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EIf/4CvtTc8=:g6eCUDLBMosgaPlslkfEPQ
 8VhNuRVM3UksAGkpEw44YTDIe0vDLtfgJph+QHlR7OHR+FMNgLFHEd0YwLbm35trb8w5vhNeG
 Kxnl2qpWkE+KJBJbi5jwh9q6G2sU3IyR0nB1e7CfT0guIOvHmFLzCup8xDDNCH8uv7B2rwiVx
 jfYb2YegKeexyLy8TydwopFLfXqod5QG6usBGtdTub9O2Xk7twqMcJOa52qtGqbePW+Hpmj4s
 YVvZdNXyrNByoYCgYooTVvw5FmYxWYfT4t+Cqu1ZzFJhv71SwDGMamn3In5hqzbqNTDQ2jkzE
 C3pCPT1DmtGSx/WLqI513ySthVtY6icrCkUMJjJOeFyMGsKc8vrPMx6ZdixZqTEozukHvv3J5
 pztZxeWNFlIVr53bfeRQlolb+EYTDSIZhog27wG0Sw4UKB2iR97J17viMT2/p6RMbKbOn6QHf
 TxTHF2jVvq6dExf64S/LFu4D+wWVSFMN6vuwVLhmRgvCihqH/6t4JQGrPWJllKtO2G699gfAW
 8cuKoKJo+m37GTC4xobQ2qtyiSbYm/WqQZqin4g410iLp6o6HXyIN7RKWTAHvrS8A9Kf9qHPV
 LpmAC4zrerirzHiffkus82SQ9201hEcDlNyX1ZhdFcgkf6TByxFNjdPfKPsAvUqtlO63ufQG3
 2j4DniurotN1KNcQ8a7pLM53oFhjdBGM84TeSkUPfkCoVuR+/8iav0I1fJYaHCGubm8wrq7VD
 D4BxGQ/6w9LygPsOnQ64GNkepVs/DqBX0QuY6FKCYVjEGvIBn85XJ4CBSoxCmMvmjLsrEydFX
 KU5PtpT3fp3J9tn2ywt/ZqsMdW9yU6CldXTPX2UV0JyEuNrmYk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 21:49 +0000, Roman Gushchin wrote:
> On Mon, Oct 29, 2018 at 09:46:54PM +0100, Mike Galbraith wrote:
> 
> > Ah, I have cgroup_disable=memory on the command line, which turns out
> > to be why your box doesn't explode, while mine does.
> 
> Yeah, here it is. I'll send the fix in few minutes. Please,
> test it on your setup. Your tested-by will be appreciated.

Yup, all-better-by:/me
