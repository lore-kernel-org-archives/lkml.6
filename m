Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1187135-1524488343-2-1478603567902733123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524488342; b=GQLzqAaCJbxuDiPoFSiZHLEzK8cm/ev5UdSgnwKcQ9qfVofbSV
    nA4GolmrK4iGYYkVD59ke+TCbiIGG7a5qCUSXahWXoh7Nrw/BfaaUEv7EwInMB66
    ibM5eQumj9/Z+YGWn+s7se2pL9iuijXVyFH87WDBix2b1j9/t1jLi8rJZ9ivIZq9
    5X0NzdRgXdt/m2rr3gyHR26XM+2ZwQ/09114jfMrdTs/b9pA/TT5QYP5a1XGIZhK
    sX7hyiImHeTok3zZn5Ut8SDsvAuQyYIUNMihGBYtleebM7GehbhtmXdpr6/0ybpw
    lcxszeQWyK4WzIE9QyeJaLdpD+R9nrktjbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524488342; bh=9yHsN
    XJq7FgelRxOmo7s8++88xOB+gtDhqYkZ0afk6E=; b=gmmjCqi4X6M9Wf43lgFmj
    XXgFLwXS/Tg6upgPpl6EUKKx0BWiKuSbx8MiYhkoFR7LfLuyEHN1famZTKcIWDFe
    Y5A4DAOo21PmJf9bHRvslkR9YDdvbjS9oz3odmjRcu2NKc0PTlblZasis1Fnn9bj
    R8AgROaqyKvjRGLTT66bww/01Ibyndzvdgl5GzajUlKvG68EixvN4w55Q8HjuBpl
    NqP+6VJVJeEbocZkzAuMwoE4Z7B2E7ffPacd3IddzFMY46MMd5h8MyakTJgkzQBH
    yQ+/vL7rQ9w3YmSpQUfdEEWurcAycopGlUEpZ0db8nihZsDX2mWZ1097/4jAcFXE
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGlKNryN4le+h6Y6L6pp1gdX+vUDdCA6f0q5aQQL6/oSD/D9ka6aVYtPBWdXhY6SEH0hw4jEUyWNOMSJFmVl8Xug+tRXnw1POi6ytFH9uZal3ENxEoRk
    hgfEYnEg8MeRnJnCL960oBbka34IUhwGXcLi+oHqLcCNETp3elbrQTgogmBY8Qy2HKEya42pQKMklnTZC1lgDKD/aeUSLF427TAz+hgVuybSabnJczdP5zW6
    NPJdoCvubbkcIrw7+GijLw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=xfhPU2_lTI8aZTW7G6YA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 14:58:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 00/25] staging: lustre: libcfs: SMP rework
Message-ID: <20180423125851.GB32162@kroah.com>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:09:42AM -0400, James Simmons wrote:
> Recently lustre support has been expanded to extreme machines with as
> many as a 1000+ cores. On the other end lustre also has been ported
> to platforms like ARM and KNL which have uniquie NUMA and core setup.
> For example some devices exist that have NUMA nodes with no cores.
> With these new platforms the limitations of the Lustre's SMP code
> came to light so a lot of work was needed. This resulted in this
> patch set which has been tested on these platforms.

I'll wait for v2 of this patchset based on Dan's review before applying
them.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
