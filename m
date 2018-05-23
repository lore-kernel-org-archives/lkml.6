Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeEWLcf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:32:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48480 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeEWLcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:32:31 -0400
X-Google-Smtp-Source: AB8JxZqOo+s/DZn8sxXNb1p5DO3ADJmjE87owOdEekpLuu+umSDqtdQjprKERkgu62WvTjtwQRT1UJi91RnoyX+iKf8=
MIME-Version: 1.0
References: <20180505154040.28614-1-pasha.tatashin@oracle.com>
 <20180505154040.28614-2-pasha.tatashin@oracle.com> <20180523104029.GC15312@amd>
In-Reply-To: <20180523104029.GC15312@amd>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 23 May 2018 07:31:52 -0400
X-Gmail-Original-Message-ID: <CAGM2reb8emos6F+zqKLxDg4u23PHXC=phUbDiJH2YU8k_DtFMg@mail.gmail.com>
Message-ID: <CAGM2reb8emos6F+zqKLxDg4u23PHXC=phUbDiJH2YU8k_DtFMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drivers core: multi-threading device shutdown
To: pavel@ucw.cz
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Alexander Duyck <alexander.duyck@gmail.com>, tobin@apporbit.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8901 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=734
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805230117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thank you for looking at this patch. BTW, the version 5 is out. The latest
thread is anchered here:
http://lkml.kernel.org/r/20180516024004.28977-1-pasha.tatashin@oracle.com

> ixgbe is network card, right? So ... it does not have any persistent
> state and no moving parts, and there's no reason we could not "just
> power it down"?

True to what you said, but the same path is used for both regular reboot,
and kexec reboot. In the later case we want to make sure that devices are
quieced and do not send any interrupts, do not do any DMA activity, and
basically in the same state as when system was first cold booted, so the
driver initializing functions can pick and bring the devices up. My
understanding is that because we do not want to diverge the regular reboot
and kexec reboot, we do it for both cases.
