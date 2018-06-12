Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5FC14C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BC62089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BC62089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935145AbeFLChU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 22:37:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:40343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935104AbeFLChT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 22:37:19 -0400
Received: from homer.simpson.net ([185.191.216.58]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHX4u-1fPHOU3ogm-003JHD; Tue, 12
 Jun 2018 04:37:10 +0200
Message-ID: <1528771029.11952.4.camel@gmx.de>
Subject: Re: [PATCH] Revert "debugfs: inode: debugfs_create_dir uses mode
 permission from parent"
From:   Mike Galbraith <efault@gmx.de>
To:     Laura Abbott <labbott@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 04:37:09 +0200
In-Reply-To: <7afa9f6a-f37d-384b-d719-bb5e50a00442@redhat.com>
References: <20180611092810.21886-1-tmricht@linux.ibm.com>
         <7afa9f6a-f37d-384b-d719-bb5e50a00442@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pLiX+EzIeKdn03NhNA0bhXWuWjZLEpTlebm1Dco5tTRXu00znDG
 mpFklFJExkgPUQNixsIS1juUTxzK/LPsIQ/IB2e3ggGwKZdedPt8ZNXNrK3lGyZfoM+PGUo
 uIrFdp31vsKJncyjEW8CFQZ5//2rXah4kt8BfbLE+LQ7Oq9ArvG1zt7A+PpmcGgKm5+IVew
 bvgCSIOxpmX9lNvs5Z2Lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aW+RtTm6q5s=:muGlU/vYKGe+elwN3Lz7QZ
 o2NGhLtbN/7YKj+UPRLhNwZ8AO69MA/4aSio9AonomenbukhWNc3TDi5Oj9YwxJr4ci06zmh/
 2qtosyJAClAHBPkhykHuaxgG7sc3dfSG7iYA6ohc2wZPGdpKusXxxWQqpt0IVJS5Gl5wv2krx
 6mlPE7VXC/Q8nE+aVwTtXzsFpz28nBSxQJjN7QWfI7QXy5JewaYZmopI05Pb6eLAFSSWWcek/
 IRV1qsVPNXOoDJuU9Jmj93rUNtNGk/zKPtrF5shvEEl9oPf65+MgaXzXNO31qVNLOUUIZvvSx
 t9lfZY1+xihkAmZtpGCBfTDnsfxVPxATlBY4RjKn5vp8XnMw+fmveS2TyGlMx2hr93UDLaPOP
 eXUEXj3OwpP198oAl3rzzyLZh5H0oO0NQZkiFaAZkU8sOqG8dStrePtkiLNufOHya2Srs9eFl
 MOfXdpVXIOBb6nD4JKwA4qbNVfjtJPYRABwTNY2Xcn5ZX4VKXfSP3oO1Qx7AP5HWyfENgOegh
 KbujgDIwDSri/l56kPdNeXszTBVt6JycDomfRfp0resghD1C52sohZ0I4K7GMTx0Dp0Dgv5vs
 j6vo9/pzItcupvGUYKxDd5xnQ2Tg0iq5GHL3LRXbil3ikc8kqQmBHxMhmNeda3cw9N1V8lVCM
 /L0tu6YSxwQDCLPOlGPCjoac3GnmSgxh7A25cre1BoUuNzeecIagcnKesimo4VEcFoaTb6XcN
 ZYENEe8FzTgqKTaBpDIXApAodvfGp+SKKahaIW63Oazsmk9eYIfIn5zzuQFXx8CVytCvl5LuX
 9tIgpbc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-11 at 11:12 -0700, Laura Abbott wrote:
> On 06/11/2018 02:28 AM, Thomas Richter wrote:
> > This reverts commit 95cde3c59966f6371b6bcd9e4e2da2ba64ee9775.
> > It breaks the ioctl(KVM_CREATE_VM) interface.
> > 
> 
> Can you elaborate a little more on how this breaks? Fedora has
> gotten at least one report of a failure in this ioctl and
> I'd like know if it's the same issue.

What I reported is here https://lkml.org/lkml/2018/6/8/79

	-Mike
