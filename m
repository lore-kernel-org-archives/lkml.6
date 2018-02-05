Return-Path: <kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2598244-1517838990-2-3551633124950294936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517838989; b=d9vZLbKPqrrbeSVsXOcZZBH4pvVP8eCMQr6RWff0klgzQre
    Ao/N0UMcpNgqeXhneEro8/DC472gOA33XBJ5ClbnhQNz764PjRBqI0QEZ+3hMH+7
    IK4ufxpLjXdl34RjNfTVHSw4gMdP5/8aRZ0fmlFjH8t7IBqfCiDnuVH9UBERxeag
    x0S9Ak2oamg8AwaC+qW37jQTrpfseRQOgU1ivZplaN/MYmxZHhTiaAw+I+PxNS4H
    0qfuZwBqJ4TvQ2lzx18lZ6oUq13DNtam6SEHLsXoIyzM50ZaGl8lDTm0jpLQoNRN
    jz1ksPQA0xZnvuueySzAIG4Vg2yOk97C9wbN5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1517838989; bh=cVsTvlbn
    Qno1Mr1a3b3QC3U1P6vz3Jk9vzeslJ69B2I=; b=RuWRKHXVLqOJcGVBn3GYkog7
    4x35unzRcVxRKNwlhsQ2JylvGdrHyk5KMDfV3SBjLUxFo3Ye1X8hSjysgTdqWIfO
    wo6lpIPf5jQn1RWYq9wVQFTnILCqRhzZbD4Uvb+ZLjcnqom75V1foAziRdhSlBiQ
    KB1wgptaJFXukaOEc8zW9DCDznvskrU6NMTspmgp5RnXYzM4H1jblFsOHV5cuFt+
    49j+YmqK/+BZnlQrtvIpEuRrRZdqdqUJmfILr0yKdgYj8g6bMoiKbuq8+PGaWbQo
    3aWIBJH5vWXghAJjkNqETXc7vtinuUY01zd06hJxV8VVTy/DTcgctl6Mt9sBCA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3DF21734
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 5 Feb 2018 22:54:02 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Pintu Kumar <pintu.ping@gmail.com>
Subject: Re: [perf] perf test BPF fails on 4.9.20
Message-Id: <20180205225402.f0b2448650763bc5cb8099a8@kernel.org>
In-Reply-To: <CAOuPNLgnazHNKoMozZq7Ef=rEwRG=rwktsnp8jCKCD0gMH+hbg@mail.gmail.com>
References: <CAOuPNLiVQEroimgO1jhSdbyPAUvBtpA5-qscBY3N1yoNYpa82Q@mail.gmail.com>
 <CAOuPNLiropE67OWuh3mWzzN3q-8+UivKuNT+PU51aDoQwrJjNw@mail.gmail.com>
 <20180203221935.bd3036aba7637a4de391a20e@kernel.org>
 <CAOuPNLgnazHNKoMozZq7Ef=rEwRG=rwktsnp8jCKCD0gMH+hbg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Cc: "Wangnan \(F\)" <wangnan0@huawei.com>,
 Alexis Berlemont <alexis.berlemont@gmail.com>, daniel@iogearbox.net,
 kernelnewbies@kernelnewbies.org, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org, acme@redhat.com, peterz@infradead.org,
 mingo@redhat.com, huawei.libin@huawei.com, naveen.n.rao@linux.vnet.ibm.com,
 quentin.monnet@netronome.com, maddy@linux.vnet.ibm.com, davem@davemloft.net
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 5 Feb 2018 15:17:41 +0530
Pintu Kumar <pintu.ping@gmail.com> wrote:

> On Sat, Feb 3, 2018 at 6:49 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > Hi Pintu,
> >
> > On Fri, 2 Feb 2018 19:03:30 +0530
> > Pintu Kumar <pintu.ping@gmail.com> wrote:
> >
> >> Hi All,
> >>
> >> I have fixed both the issue with perf test.
> >>
> >> 1) 16: Try 'import perf' in python, checking link problems      : FAILED!
> >> To fix this issue, I have to install:
> >> pip install --upgrade pip
> >> pip2.7 install perf
> >>
> >> 2) 37.2: Test BPF prologue generation                           : FAILED!
> >> To fix this issue I had to enable full version of CONFIG_DEBUG_INFO in kernel.
> >>
> >> Now, my question is:
> >> Is it possible to pass BPF test without enabling CONFIG_DEBUG_INFO in kernel ?
> >
> > It depends on what BPF test does, but it seems to access local vars. This means
> > you need to enable CONFIG_DEBUG_INFO. With debuginfo we can find the assignment
> > of register/stack for each local variable.
> >
> 
> OK. Thank you so much for your reply.
> I think we don't need BPF test at this time.
> Is it possible to disable/skip it ?

It depends on what you want to do with perf. If you don't use BPF, yes, you can
skip it :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
