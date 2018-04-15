Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3779843-1523770932-2-10883191354878681802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, HTML_MESSAGE 0.001,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8', html='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523770931; b=DVctKCh7knSnDNCe0j5DfwGdGfQ3x3o3vp12aIBQyxTJTi8BIG
    GijRdv1HQQoYFArZ532O+5qDL8uB066SMTeUFOdeX0KZMTkKiXk+F4AHBXF90fUT
    nXq3XQRhVMXKphRLLBbqm/yTinf1RehMINiIunadg4xcNxuKoYI6O0O0AAZBfQ3z
    fQQd+VWXwFHK/qdJK6QqBcwr0C6jCnmhp0WicnjZD3/7VmctKfFtrOnbWb+ujCCQ
    8ql7+o6kWG4yNvX1vii3iVH/q/fsJRWV39IXuM/v0t7F6OhRi2cBwYGMybmwDtYN
    Wkoi/igJ9/AEH1MDbl72nCeNztAc+4hqRxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:list-id:list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:content-type; s=fm2; t=1523770931; bh=fz30h/TBuJ
    49KKffGfVL7lPugPO4cJJlFRdvH56LMB8=; b=daHlc44+LvQFTQvgnMHbnnJTgS
    Gpa9ucqNpJIqIA2libvDDjh3GOn5kprL/owSuNcGTZZT3q9LZO9v5ICKEKA5Aekb
    rgdReyKb4j5Oe/3xXfS7QwertlMwUTkMkjufdZ2snd8GDEx7DkZlOtfRXqzVdFPj
    O2WYHD9BhCOk6t77Z+1sjYx9W8Mh9//AvTm87piLrO5nPxmUtQ5HGtaaAHZcFW1z
    SE/0YnEsveuyDp2xLYv+09ZEx/ru6CqI3qSEkYrVeXlLys9xud/GMUnc8jJFCBEO
    7d/HtqXuCD9rbhqCY54s4W7kNOXyC0kOOBx17W0ZrVYUGvP4jVfFXamGcTyg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GyXFQ9Np x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cwB48umy;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GyXFQ9Np x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cwB48umy;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAYHbMk2jWJ4uwWrcdByaMLj9n2Ixv+UM58TdwzfNtauzlE5v+k5dcxrmLb1b7Bb4WismI2Ep4NhKShgJw4AC6FoD+thaUWLexsWYA1hcWVMYuSM5j6V
    CweDmRkj2Qh9mOOb/c9bypyBparje6ZSiw/6EeEjk2A6vHMZCoO8Ih5rMzH5SauCTDflPgzkaULhro2KsSoSD0UxFkcOeAUHpcc=
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=x7bEGLp0ZPQA:10 a=bDeEnmz458gA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=CtLtDomN3U-Uww0YgNkA:9 a=QEXdDO2ut3YA:10 a=dsNvaMZuJW5GOqmu_VgA:9
    a=ymj4xvFyZ-T9_9vY:21 a=SiqW3_QkAAAA:8 a=pA5yba_4-WtoxGtPXkoA:9
    a=CjuIK1q_8ugA:10 a=Fe-e93FlemcA:10 a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Google-Smtp-Source: AIpwx4/GmhnXIlKm/HCCokQU9/fgAwUOuHdYE0ezV2N5KHS3FNuBFiNb+BDYmslqeWUp1sDQaIvFkftlSKH/ew42sEg=
MIME-Version: 1.0
From: Ivid Suvarna <ivid.suvarna@gmail.com>
Date: Sun, 15 Apr 2018 05:41:35 +0000
Message-ID: <CABXF_ADbsQUFa4u0iG=nUYgWUtYa_pnwQghsU49zk+xVag3_vQ@mail.gmail.com>
Subject: Softlockup and Hardlockup sample test module
To: Kernel development list <linux-kernel@vger.kernel.org>,
 kernelnewbies@kernelnewbies.org
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7837820202723922425=="
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============7837820202723922425==
Content-Type: multipart/alternative; boundary="001a1144f7aa982c810569dc8f62"

--001a1144f7aa982c810569dc8f62
Content-Type: text/plain; charset="UTF-8"

Hi All,

Could you please provide some sample test module for causing a Softlockup
and Hardlockup in latest kernel for SMP for only testing purposes. I assume
there are some Kconfigs to be enabled as well for this.

I had tried with the module where I put a busy loop inside spinlock but was
not able to cause any lockups. Maybe this is because of SMP which schedule
the job to other CPU. "How do I make a task to run on single CPU only?"

I only get RCU stalls sometimes instead of softlockup when I use busy loop
inside a spinlock. Is there any explanation for difference between these
stalls and softlockup.

Thanks,
IVID

--001a1144f7aa982c810569dc8f62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi All,<div dir=3D"auto"><br></div><div dir=3D"auto">Coul=
d you please provide some sample test module for causing a Softlockup and H=
ardlockup in latest kernel for SMP for only testing purposes. I assume ther=
e are some Kconfigs to be enabled as well for this.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">I had tried with the module where I put a busy =
loop inside spinlock but was not able to cause any lockups. Maybe this is b=
ecause of SMP which schedule the job to other CPU. &quot;How do I make a ta=
sk to run on single CPU only?&quot;</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">I only get RCU stalls sometimes instead of softlockup when I us=
e busy loop inside a spinlock. Is there any explanation for difference betw=
een these stalls and softlockup.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks,</div><div dir=3D"auto">IVID</div></div>

--001a1144f7aa982c810569dc8f62--


--===============7837820202723922425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============7837820202723922425==--
