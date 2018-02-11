Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3993364-1518392683-4-9342784260169942422
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518392683; b=Pp1qi0gjsAPU/ehbkKW5A0UEEEKTnp+JVS8uTBU9yTDd/Cl
    lsQtPUkFF8Fis33au66Cd1ZpWa72IXnEQqyMxFHf3YauyBLbRYM2ERucVvf+ReGs
    L/BgA9zWq7dS3DwhIsxAN1A+wbl8MLiFEoSAQmkxBcEFD8i/S2qpuS+qN+WQ0EDx
    gFYeHGw0P1tSdcVsK9dXHQJ4LlkUSzS79rNMGah7WoUbSiE5JfMiNQvgSOfgZgKn
    KejXdkbtqr6zdlZefTcXJ77Jj/myvqdonsriZu3SKJ5wgBqzUT0iCUHwHdPrj2kT
    pVd9liZfK67RBbCMhCembM8mBUWj9EGADc/WXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1518392683; bh=RgjlmHl19B7qiyPsxoeiLeUGXSQ
    HzdJIKA+2P0yDKyY=; b=L4Iinautbm6DWNB0f4ttDjp6P0HnhhOwZbE5iYPYaH7
    XJdCYdyeTLRTCHy7KSYj9ZvSj25CnswwVi1MOJdT/okxGa89R7FrQsYZem6gS0qX
    aAyuYXaNChSNQ40fxY4RoYtzJeQotm8/4hsjVTsy6Fm8KJBOKEf7n3SzGmL3kT1O
    v/gzSOQ+scf8LJgPxt5d5itJjjMhFhwX4rDaLJS8v34ABAwld9+H/iWTQhBdcC1S
    2r5Tsw9d8MI64m2wx/kd728DllO1+u7WdzBHcC7rndc41Y3/JO8aoVoFT1MZRNjc
    IaPb9r0EIQgpNGjtg07PBOOfBIkyWIwRBCZDTyVXw3A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>
Date: Mon, 12 Feb 2018 10:44:23 +1100
Subject: Re: [lustre-devel] [PATCH 41/80] staging: lustre: lmv: separate
 master object with master stripe
In-Reply-To: <FC7E817D-BA15-4D0A-9976-F1343F9B022A@intel.com>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
 <87r2pvkkl5.fsf@notabene.neil.brown.name>
 <09CE6CEC-52BC-4B29-B609-40DE68A64A33@intel.com>
 <87o9kylux7.fsf@notabene.neil.brown.name>
 <FC7E817D-BA15-4D0A-9976-F1343F9B022A@intel.com>
Message-ID: <87h8qnrt0o.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 wang di <di.wang@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============8826999983378787447=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============8826999983378787447==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08 2018, Oleg Drokin wrote:

>> On Feb 8, 2018, at 10:10 PM, NeilBrown <neilb@suse.com> wrote:
>>=20
>> On Thu, Feb 08 2018, Oleg Drokin wrote:
>>=20
>>>> On Feb 8, 2018, at 8:39 PM, NeilBrown <neilb@suse.com> wrote:
>>>>=20
>>>> On Tue, Aug 16 2016, James Simmons wrote:
>>>=20
>>> my that=E2=80=99s an old patch
>>>=20
>>>>=20
>> ...
>>>>=20
>>>> Whoever converted it to "!strcmp()" inverted the condition.  This is a
>>>> perfect example of why I absolutely *loathe* the "!strcmp()" construct=
!!
>>>>=20
>>>> This causes many tests in the 'sanity' test suite to return
>>>> -ENOMEM (that had me puzzled for a while!!).
>>>=20
>>> huh? I am not seeing anything of the sort and I was running sanity
>>> all the time until a recent pause (but going to resume).
>>=20
>> That does surprised me - I reproduce it every time.
>> I have two VMs running a SLE12-SP2 kernel with patches from
>> lustre-release applied.  These are servers. They have 2 3G virtual disks
>> each.
>> I have two over VMs running current mainline.  These are clients.
>>=20
>> I guess your 'recent pause' included between v4.15-rc1 (8e55b6fd0660)
>> and v4.15-rc6 (a93639090a27) - a full month when lustre wouldn't work at
>> all :-(
>
> More than that, but I am pretty sure James Simmons is running tests all t=
he time too
> (he has a different config, I only have tcp).
>
>>>> This seems to suggest that no-one has been testing the mainline linux
>>>> lustre.
>>>> It also seems to suggest that there is a good chance that there
>>>> are other bugs that have crept in while no-one has really been caring.
>>>> Given that the sanity test suite doesn't complete for me, but just
>>>> hangs (in test_27z I think), that seems particularly likely.
>>>=20
>>> Works for me, here=E2=80=99s a run from earlier today on 4.15.0:
>>=20
>> Well that's encouraging .. I haven't looked into this one yet - I'm not
>> even sure where to start.
>
> m=E2=80=A6 debug logs for example (greatly neutered in staging tree, but =
still useful)?
> try lctl dk and see what=E2=80=99s in there.

Debug logs seem to tell me that some message is being sent to a server
and a reply is being received, but that request we are waiting on
doesn't make progress.  I plan to dig in and learn more about how lustre
rpc works so I have a better changes of interpreted those debug logs.


>
>>> Instead the plan was to clean up the staging client into acceptable sta=
te,
>>> move it out of staging, bring in all the missing features and then
>>> drop the client (more or less) from the lustre-release.
>>=20
>> That sounds like a great plan.  Any idea why it didn't happen?
>
> Because meeting open-ended demands is hard and certain demands sound like
> =E2=80=9Cthrow away your X and rewrite it from scratch" (e.g. everything =
IB-related).

My narrow perspective on IB - from when rdma support was added to the
NFS server - is that it is broken by design and impossible to do
"right".  So different people could easily have different ideas on how
to make the best of a bad lot.
I might try to have a look.

>
> Certain things that sound useless (like the debug subsystem in Lustre)
> is very useful when you have a 10k nodes in a cluster and need to selecti=
vely
> pull stuff from a run to debug a complicated cross-node interaction.
> I asked NFS people how do they do it and they don=E2=80=99t have anything=
 that scales
> and usually involves reducing the problem to a much smaller set of nodes =
first.

the "rpcdebug" stuff that Linux/nfs has is sometimes useful, but some parts
are changing to tracepoints and some parts have remained, which is a
little confusing.

The fact that lustre tracing seems to *always* log everything so that if
something goes wrong you can extract that last few meg(?) of logs seems
really useful.

I discovered - thanks to James -
 https://jira.hpdd.intel.com/browse/LU-8980
 Add tracepoint support to Lustre

which is "closed", but I cannot find any trace of tracepoints in
drivers/staging or in lustre-release.  Maybe I'm confused.
I suspect tracepoints is a good way to go.

>
>> It seems there is a lot of upstream work mixed in with the clean up, and
>> I don't think that really helps anyone.
>
> I don=E2=80=99t understand what you mean here.

Just that I thought that the main point of drivers/staging is to get the
code into a mergable state, and if feature addition happens at the same
time, then priorities get blurred and goals don't get reached.

>
>> Is it at all realistic that the client might be removed from
>> lustre-release?  That might be a good goal to work towards.
>
> Assuming we can bring the whole functionality over - sure.
>
> Of course there=E2=80=99d still be some separate development place and we=
 would
> need to create patches (new features?) for like SuSE and other distros
> and for testing of server features, I guess, but that could just that -
> a side branch somewhere I hope.

Of course - code doesn't go upstream until it is ready.  Lots of
development happens elsewhere.
Of course distros like SUSE would generally rather ship code that was
"ready" and so like to see it upstream.  There is usually room for
negotiation.

>
> It=E2=80=99s not that we are super glad to chase every kernel vendors put=
 out,
> of course it would be much easier if the kernels already included
> a very functional Lustre client.
>
>>>> Might it make sense to instead start cleaning up the code in
>>>> lustre-release so as to make it meet the upstream kernel standards.
>>>> Then when the time is right, the kernel code can be moved *out* of
>>>> lustre-release and *in* to linux.  Then development can continue in
>>>> Linux (just like it does with other Linux filesystems).
>>>=20
>>> While we can be cleaning lustre in lustre-release, there are some things
>>> we cannot do as easily, e.g. decoupling Lustre client from the server.
>>> Also it would not attract any reviews from all the janitor or
>>> (more importantly) Al Viro and other people with a sharp eyes.
>>>=20
>>>> An added bonus of this is that there is an obvious path to getting
>>>> server support in mainline Linux.  The current situation of client-only
>>>> support seems weird given how interdependent the two are.
>>>=20
>>> Given the pushback Lustre client was given I have no hope Lustre server
>>> will get into mainline in my lifetime.
>>=20
>> Even if it is horrible it would be nice to have it in staging... I guess
>> the changes required to ext4 prohibit that... I don't suppose it can be
>> made to work with mainline ext4 in a reduced-functionality-and-performan=
ce
>> way??
>
> We support unpatched ZFS as a server too! ;)

So that that mean you would expect lustre-server to work with unpatched
ext4? In that case I won't give up hope of seeing the server in mainline
in my lifetime.  Client first though.

> (and if somebody invests the time into it, there was some half-baked btrfs
> backend too I think).
> That said nobody here believes in any success of pushing Lustre server in=
to
> mainline.
> It would just be easier to push the whole server into userspace (And there
> was a project like this in the past, now abandoned because it was mostly
> targeting Solaris anyway).
>
>> I think it would be a lot easier to motivate forward progress if there
>> were a credible end goal of everything being in mainline.
>>=20
>>>=20
>>>> What do others think?  Is there any chance that the current lustre in
>>>> Linux will ever be more than a poor second-cousin to the external
>>>> lustre-release.  If there isn't, should we just discard it now and move
>>>> on?
>>>=20
>>>=20
>>> I think many useful cleanups and fixes came from the staging tree at
>>> the very least.
>>> The biggest problem with it all is that we are in staging tree so
>>> we cannot bring it to parity much. And we are in staging tree because
>>> there=E2=80=99s a whole bunch of =E2=80=9Ccleanups=E2=80=9D requested t=
hat take a lot of effort
>>> (in both implementing them and then in finding other ways of achieving
>>> things that were done in old ways before).
>>=20
>> Do you have a list of requested cleanups?  I would find that to be
>> useful.
>
> As Greg would tell you, =E2=80=9Cif you don=E2=80=99t know what needs to =
be done,
> let=E2=80=99s just remove the whole thing from staging now=E2=80=9D.

Of course, but I don't expect that I will see the same things that
others see.  And if people have gone to the trouble to provide feedback,
it seems polite to record that feed back for all to see.

>
> I assume you saw drivers/staging/lustre/TODO already, it=E2=80=99s only p=
artially done.

Yes - it isn't very detailed though.  Maybe I'll flesh it out with some
of the things you have said.

>
> We had a bunch of other requests from various people ranging from wholesa=
le
> removal of various parts to making sure there=E2=80=99s no checkpatch war=
nings
> (Turned out rather hard to do, even though we greatly pared the
> numbers).

checkpatch is a useful guide, but an awful master.

% find drivers/staging/lustre/ -name '*.[ch]' | while read a; do
   ./scripts/checkpatch.pl --max-line-length=3D10000 --no-summary -f $a
   done|grep '^ERROR' | sort | uniq -c


     17 ERROR: Macros with complex values should be enclosed in parentheses
      2 ERROR: Macros with multiple statements should be enclosed in a do -=
 while loop
     12 ERROR: No #include in ...include/uapi/... should use a uapi/ path p=
refix
      1 ERROR: space required before the open brace '{'
      8 ERROR: that open brace { should be on the previous line
      1 ERROR: trailing statements should be on next line
      1 ERROR: trailing whitespace

Thanks isn't too bad - obviously nearly there with checkpatch.
Lots more warnings - some might be interesting.

wholesale removal - like the prng, the workqueues, and the
ll_wait_event() macro?  I can do that :-)


>
> I have some patches to make Lustre a lot more monolithic too.

Yes, it annoys me that I cannot build without modules.  I took some
steps towards fixing that and went off down a rabbit hole..
Should be fairly easy.

> People want us to remove our indirections hell so the code is more readab=
le
> (I have some patches that need to be freshened up some that help here a b=
it,
> but the work is huge.)

But indirections solve all problems :-)

>
> Other requests come out as some of the prior ones get completed due to
> =E2=80=9Cyou need o finish current level of cleanups so that we can see w=
hat other
> cleanups are needed, the current code is too bad to see everything=E2=80=
=9D pretty much.

Thanks a lot for your helpful reply.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqA1VcACgkQOeye3VZi
gbkNTg/7BTQGEAfbPd5uoyX2ojwk4ve8P8tFn/zBCg1wqZ0gs/VsAZD04WQ6Arpb
fVJoAQmVKML2xYkJ/FvimjI3NysnDqO/uqDxaYSjIogmibOOrIT+sQ5JwF40pTbv
28GqbNBxDkLbhrTaoY52wzk9/t7WoDTVFplapF83DTB4ZrwLfGzC8tgUPF4XhaKv
76AlXNiG4/MrV/LkBLW6s54y6YBmvnq3CQRPttUYuWAe+z6dujI384+3nUzVorMV
pEPxAfqhOTBs/cs6ZcCaKh0RIKSgHZdVUUM/yV1R/h+NDyyyHmshA1eI3ReUgzYN
unmNMmQu3BsAlCH2pM0S1ByOyMen0OVcPntVFYBTiptgSQebbdJKEbchwPmh25rT
tSkfgz/CM/gjeuNyCJh92e0kIG+wG7bqwbCTXLuTB9pDGJEYpoLfJexB0+dhxI6Z
7b4mRCySCFZ36xXiHK+xtmFWmx89GHJY5lMp/OssqKcbUYPiM5fSn+PbIgXyz0Kt
UyeumBuHnzVai1649qcpapND6IN/8VqPmwNp+LpBbUr4+5BJeUub0dYzpA7V29og
xP7vfjHuG5oJ3513aF7kCpfFdnHuapZdlt7DgNh1aU8ENDEqwjy5PUyMuhe0OHoc
Q8O5dx7x5dfKuvkF2tdp0ox06TJ4qtIDZUDpiR5yc6A/cdQiC58=
=lRit
-----END PGP SIGNATURE-----
--=-=-=--

--===============8826999983378787447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============8826999983378787447==--
