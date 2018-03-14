Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1132802-1521014013-2-3080402797959157857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521014013; b=cJ8+L0l/GLpXuJwiPw1ZakX+Tj/EL9cXbywEkci7UNWE9Mr
    5Nu0GCULgQNXbsnPTD1Oe4ah1LMtMqv5WrMGUfl4qnUx6XE7DOl4cIJH7f7VPZ9s
    fKe6vpDUByrfB7sZ5jaM6sS0wn7PteUw3nNMxCxyhTIWCzHJ/az1xOjoZYp60nZk
    zzC86qgjBP2KZIGsx+T0Z6nT/Z8Ymq1eSdRYTVWAwhUpq/Zj3hPaCL5EdVBaztNu
    UZMQ601SXqXQ0ec2X1qFmI6QDf06NtW+guUoGhPirk53xMGpf/ssrnD9MZpLwUw4
    0oqgqYpOvr8mTmsn+Qk/BsfrpmmwUvmNoArMntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521014013; bh=u
    qpqSZET2LOJF4ebgeX+iK1QtGCKNJM6Tg13Tk2SFk4=; b=vV+0o+mL+QKg60rPY
    5hIsadea+U5WU2X7JiMZySSHekBABuGjtAUSDL7a6QAj7BAbwttEJjhyyBQnNBko
    xHBNToGBtIXhv1a7Ib6MKvVlMxtG1VAl2ipm5t3YCvsbOG/AVukQ8Ki9ZLvPaDZL
    BHjzpBX04injrku8ADRe/tyEW/ULnd5s7tn6DiOWiRW6mockFaWt9TLbctdesaam
    eSROrJmrpdG+rpBCtU97SN8fUycjarogrPvr7D7TUTY1d9pZ8PlV7xujqG1indfn
    cnwwpOhAJarxO+YTvXnkC3zCbuDrvSU26DdPqvOOAnimZ5iijBQ+WJLG8HorFm+X
    CL8rQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 06:36:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH] media: staging/imx: fill vb2_v4l2_buffer sequence entry
Message-ID: <20180314053651.GB12280@kroah.com>
References: <20180313200054.31305-1-ps.report@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180313200054.31305-1-ps.report@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 09:00:54PM +0100, Peter Seiderer wrote:
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
>  drivers/staging/media/imx/imx-media-csi.c | 5 +++++
>  1 file changed, 5 insertions(+)

I know I don't take patches with an empty changelog description, but
other maintainers might be much more forgiving... :)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
