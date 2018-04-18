Return-Path: <simmonsja@ornl.gov>
X-Google-Smtp-Source: AB8JxZrIvBq8HQUojGFhBlCKDQcBsHVQh9AQxgu5+7V7GeIKdW0U7+tHFqzsKTnqPRfEn1L2129P
ARC-Seal: i=1; a=rsa-sha256; t=1524088606; cv=none;
        d=google.com; s=arc-20160816;
        b=T2jdO93FhlU2PyqPOqIucn6RwWVuTJiaDCr17HRcTuU/3OFrs4686hmvsmrQxugqX2
         CPxSNUU10/nDu0nkZ5JGYWp1X4GJziluSRDiMsGx4vhzuQGxSEO0AUrL7nh50DE1SoPE
         hXacwuqT82+s6HRbV06jfAEJUbTcqKQYOY3WRJKGV3UHm5y6mbg0UTiFyt73aGlyXg5b
         C2ndNrtaoDz7/WBPO/2p9W3ahbn8kuRNEpm/V5AP4kVd+P4JCYW9y0FxA5ChczHlWPk4
         H0WsHNWLStJ4cQsV1oeDj9oskXpPaSuAxMltqaNgu8THaQfVwVMYVquTa5xabV9vezZu
         ggqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=5BDULPzd89HpKOqZNs/KBLQCv6+zPIdCYhMA8AJQo9M=;
        b=EEw28yt0ry+GdMYf6VwFpxckDC2bxR+fULrDKOn6ZXWNBBdWomUAJV2C4P1+252J6e
         abh/1WZEcQjkVyLPsDnLrtH3lYTag51XspPet7I8amVebOGGADIz9s2FruxdoJwnpUgG
         R5h6ZeEnYZJD9pCkLPXpCnV87EKMptJ0R+DlDQYjTPGPmqnyU+c1rGlsuXMoRwDTQQ15
         y8v5FnC8TK6r5nZ3kAk20EbmCOJQ7vYnclIKyTiPt9oCHqmdH26chjhTZ91DH74bp5ju
         NEeDgorxgu6uZyK0Cd+NVLqEdEsA9tXjGY6rTGNE4+s9GPbQE9L1glgcV9mCJxmjFPWu
         hEhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ornl.gov header.s=p20151116 header.b=vCD8agiU;
       spf=pass (google.com: domain of simmonsja@ornl.gov designates 128.219.177.136 as permitted sender) smtp.mailfrom=simmonsja@ornl.gov;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ornl.gov
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ornl.gov header.s=p20151116 header.b=vCD8agiU;
       spf=pass (google.com: domain of simmonsja@ornl.gov designates 128.219.177.136 as permitted sender) smtp.mailfrom=simmonsja@ornl.gov;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ornl.gov
X-SG: RELAYLIST
X-IronPort-AV: E=Sophos;i="5.48,466,1517893200";
   d="scan'208";a="36440478"
From: "Simmons, James A." <simmonsja@ornl.gov>
To: NeilBrown <neilb@suse.com>, James Simmons <jsimmons@infradead.org>
CC: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 00/20] staging: lustre: convert to
 rhashtable
Thread-Topic: [lustre-devel] [PATCH 00/20] staging: lustre: convert to
 rhashtable
Thread-Index: AQHT11jvN8Ej3qUFH0eovqd0vexg6A==
Date: Wed, 18 Apr 2018 21:56:44 +0000
Message-ID: <1524088604572.29145@ornl.gov>
References: <152348312863.12394.11915752362061083241.stgit@noble>
 <alpine.LFD.2.21.1804170429300.14398@casper.infradead.org>,<87y3hlqk3w.fsf@notabene.neil.brown.name>
In-Reply-To: <87y3hlqk3w.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [128.219.168.185]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597488463998050383?=
X-GMAIL-MSGID: =?utf-8?q?1598122734027668822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=0A=
>>> libcfs in lustre has a resizeable hashtable.=0A=
>>> Linux already has a resizeable hashtable, rhashtable, which is better=
=0A=
>>> is most metrics. See https://lwn.net/Articles/751374/ in a few days=0A=
>>> for an introduction to rhashtable.=0A=
>>=0A=
>> Thansk for starting this work. I was think about cleaning the libcfs=0A=
>> hash but your port to rhashtables is way better. How did you gather=0A=
>> metrics to see that rhashtable was better than libcfs hash?=0A=
>=0A=
>Code inspection and reputation.  It is hard to beat inlined lockless=0A=
>code for lookups.  And rhashtable is heavily used in the network=0A=
>subsystem and they are very focused on latency there.  I'm not sure that=
=0A=
>insertion is as fast as it can be (I have some thoughts on that) but I'm=
=0A=
>sure lookup will be better.=0A=
>I haven't done any performance testing myself, only correctness.=0A=
=0A=
Sorry this email never reached my infradead account so I'm replying=0A=
from my work account.  I was just wondering if numbers were gathered.=0A=
I'm curious how well this would scale on some HPC cluster. In any case=0A=
I can do a comparison with and without the patches on one of my test=0A=
clusters and share the numbers with you using real world work loads.=0A=
=0A=
>>> This series converts lustre to use rhashtable.  This affects several=0A=
>>> different tables, and each is different is various ways.=0A=
>>>=0A=
>>> There are two outstanding issues.  One is that a bug in rhashtable=0A=
>>> means that we cannot enable auto-shrinking in one of the tables.  That=
=0A=
>>> is documented as appropriate and should be fixed soon.=0A=
>>>=0A=
>>> The other is that rhashtable has an atomic_t which counts the elements=
=0A=
>>> in a hash table.  At least one table in lustre went to some trouble to=
=0A=
>>> avoid any table-wide atomics, so that could lead to a regression.=0A=
>>> I'm hoping that rhashtable can be enhanced with the option of a=0A=
>>> per-cpu counter, or similar.=0A=
>>>=0A=
>>=0A=
>> This doesn't sound quite ready to land just yet. This will have to do so=
me=0A=
>> soak testing and a larger scope of test to make sure no new regressions=
=0A=
>> happen. Believe me I did work to make lustre work better on tickless=0A=
>> systems, which I'm preparing for the linux client, and small changes cou=
ld=0A=
>> break things in interesting ways. I will port the rhashtable change to t=
he=0A=
>> Intel developement branch and get people more familar with the hash code=
=0A=
>> to look at it.=0A=
>=0A=
>Whether it is "ready" or not probably depends on perspective and=0A=
>priorities.  As I see it, getting lustre cleaned up and out of staging=0A=
>is a fairly high priority, and it will require a lot of code change.=0A=
>It is inevitable that regressions will slip in (some already have) and=0A=
>it is important to keep testing (the test suite is of great benefit, but=
=0A=
>is only part of the story of course).  But to test the code, it needs to=
=0A=
>land.  Testing the code in Intel's devel branch and then porting it=0A=
>across doesn't really prove much.  For testing to be meaningful, it=0A=
>needs to be tested in a branch that up-to-date with mainline and on=0A=
>track to be merged into mainline.=0A=
>=0A=
>I have no particular desire to rush this in, but I don't see any=0A=
>particular benefit in delaying it either.=0A=
>=0A=
>I guess I see staging as implicitly a 'devel' branch.  You seem to be=0A=
>treating it a bit like a 'stable' branch - is that right?=0A=
=0A=
So two years ago no one would touch the linux Lustre client due to it=0A=
being so broken. Then after about a year of work the client got into =0A=
sort of working state. Even to the point actual sites are using it. =0A=
It still is  broken and guess who gets notified of the brokenness :-)  =0A=
The good news is that people do actually test it but if it regress to much=
=0A=
we will lose our testing audience. Sadly its a chicken and egg problem. Yes=
 I=0A=
want to see it leave staging but I like the Lustre client to be in good wor=
king=0A=
order. If it leaves staging still broken and no one uses it then their is n=
ot=0A=
much point. =0A=
=0A=
So to understand why I work with the Intel development branch and linux =0A=
kernel version I need to explain my test setup.  So I test at different lev=
els.=0A=
=0A=
At level one I have my generic x86 nodes and x86 server back ends. Pretty=
=0A=
vanilla and the scale is pretty small. 3 servers nodes and a couple of clie=
nts.=0A=
In the environment I can easily test the upstream client. This is not VMs b=
ut=0A=
real hardware and real storage back end.=0A=
=0A=
Besides x86 client nodes for level one testing I also have Power9 ppc nodes=
.=0A=
Also its possible for me to test the upstream client directly. In case you =
want to=0A=
know nope lustre doesn't work out of the box for Power9. The IB stack needs=
=0A=
fixing and we need to handle 64K pages at the LNet layer. I have work that=
=0A=
resolves those issues. The fixes need to be pushed upstream.=0A=
=0A=
Next I have an ARM client cluster to test with which runs a newer kernel th=
at =0A=
is "offical".  When we first got the cluster I stomped all over it but disc=
overed=0A=
I had to share it and the other parties involved were not to happy with my =
=0A=
experimenting. The ARM system had the same issues as the Power9 so=0A=
now it works. Once the upstream client is in better shape I think I could=
=0A=
subject the other users of the system to try it out. I have been told the A=
RM=0A=
vendor has a strong interest in the linux lustre client as well.=0A=
=0A=
Once I'm done with that testing I moved to my personal Cray test cluster.=
=0A=
Sadly Cray has unique hardware so if I use the latest vanilla upstream kern=
el=0A=
that unique hardware no longer works which makes the test bed pretty much=
=0A=
useless. Since I have to work with an older kernel I back port the linux ke=
rnel=0A=
client work and run test to make sure to works. On that cluster I can run r=
eal=0A=
HPC work loads.  =0A=
=0A=
Lastly if the work shows itself stable at this point I see if I can put it =
on a Cray=0A=
development system that users at my workplace test on. If the user scream=
=0A=
things are broken then I find out how they break it. General users are very=
=0A=
creative at find ways to break things that we wouldn't think of. =0A=
=0A=
>I think we have a better chance of being heard if we have "skin in the=0A=
>game" and have upstream code that would use this.=0A=
=0A=
I agree. I just want a working base line that users can  work with :-) For =
me =0A=
landing the rhashtable work is only the beginning. Its behavior at very lar=
ge scales=0A=
needs to be examined to find any potential bottlenecks. =0A=
=0A=
Which bring me to the next point since this is cross posting to the lustre-=
devel list.=0A=
For me the largest test cluster I can get my hands on is 80 nodes. Would an=
yone =0A=
be willing to donate test time on their test bed clusters to help out in th=
is work. It would=0A=
be really awesome to test on a many thousand node system. I will be at the =
Lustre=0A=
User Group Conference next week so if you want to meet up with me to discus=
s details=0A=
I would love to help you set up your test cluster so we really can exercise=
 these changes.=
