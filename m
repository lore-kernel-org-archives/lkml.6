Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeCOROb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:14:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45578 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeCORO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:14:29 -0400
MIME-Version: 1.0
Message-ID: <0d84d286-9965-45cb-93c8-379ca1b2441e@default>
Date: Thu, 15 Mar 2018 10:14:01 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <shmulik.ladkani@gmail.com>
Cc: <netdev@vger.kernel.org>, <mrv@mojatatu.com>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <yuval.shaia@oracle.com>, <idan.brown@oracle.com>
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=652
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FHEZx2027231


----- shmulik.ladkani@gmail.com wrote:

> On Thu, 15 Mar 2018 09:35:51 -0700 (PDT) Liran Alon
> <liran.alon@oracle.com> wrote:
> > ----- shmulik.ladkani@gmail.com wrote:
> > 
> > > On Thu, 15 Mar 2018 08:01:03 -0700 (PDT) Liran Alon
> > > <liran.alon@oracle.com> wrote:  
> > > > 
> > > > I still think that default behavior should be to zero skb->mark
> only  
> > > when skb  
> > > > cross netdevs in different netns.  
> > > 
> > > But the previous default was scrub the mark in *both* xnet and
> > > non-xnet
> > > situations.
> > > 
> > > Therefore, there might be users which RELY on this (strange)
> default
> > > behavior in their same-netns-veth-pair setups.
> > > Meaning, changing the default behavior might break their apps
> relying
> > > on
> > > the former default behavior.
> > > 
> > > This is why the "disable mark scrubbing in non-xnet case" should
> be
> > > opt-in.  
> > 
> > We think the same.
> > The only difference is that I think this for now should be
> controllable
> > by a global /proc/sys/net/core file instead of giving a flexible
> per-netdev
> > control.
> > Because that is a larger change that could be done later.
> 
> A flags attribute to veth newlink is a very scoped change.
> User controls this per veth creation.
> This is way more neat than /proc/sys/net and provides the desired
> granular
> control.
> 
> Also, scoping this to veth has the advantage of not affecting the many
> other
> dev_forward_skb callers.

Agreed. But isn't this an issue also for the
many others (& future) callers of dev_forward_skb()?
This seems problematic to me.

This will kinda leave a kernel interface with broken default behavior
for backwards comparability.

A flag to netdev or /proc/sys/net/core to "fix" default behavior
will avoid this.

> 
> Regards,
> Shmulik
