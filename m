Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D36C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3B0208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3B0208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbeHAJdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:33:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:47799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733177AbeHAJdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:33:05 -0400
Received: from homer.simpson.net ([185.191.219.92]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI8iw-1focxS0Myk-003yJG; Wed, 01
 Aug 2018 09:48:32 +0200
Message-ID: <1533109710.4735.37.camel@gmx.de>
Subject: Re: bisected - arm64 kvm unit test failures
From:   Mike Galbraith <efault@gmx.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 01 Aug 2018 09:48:30 +0200
In-Reply-To: <864lgey2ja.wl-marc.zyngier@arm.com>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
         <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
         <1533061729.12487.26.camel@gmx.de> <867elay7he.wl-marc.zyngier@arm.com>
         <1533103345.4735.19.camel@gmx.de> <864lgey2ja.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:t1Eit9OF717hKa315pT0676J2gpVNvDeES5Zh56oEQsRyiwOfar
 zd6WARMm2y6OhOcfU/8jmwOJ6JlsMJufPf3A2rbmSHyZZMfOeER0sOO3BaSIcrGZg6TXepV
 sD6vOvjYMBETV2NurYYsr8zlewoAZxoeQWFHr1bi0Kcs6PQYhBkoIlXuMrau+YgOorVGNxY
 9sNu69afzBSfztOuKlJSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rq7e0vdwA3M=:Ad+sK9BhP3VffMq0/7Pwx4
 4AnDMENpHE3l227kLX4asvxG5pxPDps3YwoCWXPuvBgGJQk3G1Ex0EIj+63k9jQVPg2B4xlnm
 E5rmkn6/WokySM9S5S3lZXFJHwP0syAXbwHFfiyMfPihHEWPfKjzfstrEPwHr7kmitF/Y056U
 IRJ0LvllF6S2rbMZnuHCdmKRnAjzzOlDSbz3eunH/Cx+SRwtitrykvGqjMU8hT7fPkzOkqRDx
 a0Y0banHTNeDSkIwGmQdFHKlRTYvQ00H2J4NAXeWgY/el/D3XOTg7kZ6LhVwg4Ib21DfBElFL
 KAiVJwdRoX+dT+MmnxP64kqSHe7rzfQYbmNoLhpmDN25Fv8u2mZ6iCa3GuyOwMq1nauNgn2j0
 Y+CYGtAfZjHp5m0b8CX2vmy9PaN9bU5+wkcgq/xYGK/cyuag/bcacn3GTavtbDtmUShs2ViRt
 710poCrQVERRm9YBnLstcQBjtRpQZxe8W975EPXGum0pTkmBfYisOHuVONH1Ohln163J209yy
 Nv146oKo2BeD58jEjZgWSYbBmwMj+HzmAUI9wnWYqhUSZOJ0+W6cDjePbE/d0m3bbRTEFWG1s
 GvPV+mua3C/6NiLT6TVxJX076BcqQfGbyELvCJ2pAIfsdPOmBkG+gMRFjv0c5yZ4aqRienN4J
 HBGY3nGzAWPlgCgBrcSvRxTdQuZxdT3pJ77KvRO1ypN/+cij85YhLgqDJhaHfY2T6ZfwQyDL0
 4UgeO0gYx99IIKThDACdLH3P2ZBs38Smy1LcDurCrbAcAgdLjlOkDkbXR7dXxYKtS+2NzJYbw
 u4pcADM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 08:22 +0100, Marc Zyngier wrote:
> 
> > Box is a 4 node/64 core TaiShan 2280.
> 
> Is that what is also known as D05/HIP07, with 64 Cortex-A72?

No idea, our rent-a-box web client shows nothing informative.

	-Mike
