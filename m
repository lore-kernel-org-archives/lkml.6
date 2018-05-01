Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2975324-1525169121-2-6850206252474761770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525169120; b=mImnf2tDEY29p5ZNZWVYpjSyJ0iEcTEfqZY+m3jxbjQPIC2dAB
    VfpQjQS7vfRWgAGcCRUAV+JfYJYjyfLGTqQgh4kKiqezjwlq6NEXiSsCiEr7xng9
    YA9wMNTW/9MKV9h0+UJeI6qGDB7hWvYocs+1F0io0tJoq9/1c0N0jrWPk7Bdgdel
    7CDuUSIMFzfoQFHwfF/5bSdurkU8nlTaH+VNZmgLNVMgG5fD0IkINdGrTpawAhRn
    6v4NWUg9ydGx8I3acnlGP0Sq3ccrvA1yvlLXixzG+QAef/rELe7iTEuBUJslP1ND
    ekUhdg5ozEwcrfxvAkLeK4WoK1EphRBk6IqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525169120; bh=gYEjQjFUPzG
    BoMLpcoop7dlKkVoKMw9qw0uN0eA9+9s=; b=lAuwJYc54QT/v1eFWZpuYH1sRaM
    0P0TpRfTzDBjxJCBBkP6bmTMhslzhm/rA97ZPEORuBx1LGqvANBN61utTKDN4L9Y
    lYyA1SUlXqiWps9eTAZ2t48T5uEprREXAzXnz7WWBsQ0UuqWccdWfIl/OAcUxhDj
    Ku7dIcufgINvmiIZ1LqBilMXgdIgu079m0GxkEC7MQytu2XftPBfrDSUNauTja5y
    6B1OB59SkhMtFMmEe+r3w1v3Oeu3ino8dkIQFWfvcOFNEA8NMlsFEFQsotkXsfps
    me1WuL4Fw0iUWqb8nbUfzOrEedeWmH1usMx5TkkcQz5UE0PDbTwM2xEf/Ng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCCJ5b515qpolgLJ7hNi9o/ko9MN3M6556k+DRKgcEQUpUI0TnWNcZ6K4CDMpCfuYwNzJSwD7xd9o1HoiZZBTXFlFoxepcnUvFi7qyfMLkTC0Ug0eq9N
    AB7WGN/ntPUDQYk16mYgynldvLCexl1WmAS2XhHRnJz+Rgni4H027GlMvS/QFcbxqRcLztl+oTYyZDdDS3ELIXjRVt6AAK87JE5WU6tzfA/hk7vP7tX4rypH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8 a=0V0yHqixiIOxBLXv9UEA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=s88AYcEWOXMFsoP9cgP2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeEAKFT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 06:05:19 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:46280 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeEAKFS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 06:05:18 -0400
X-IronPort-AV: E=Sophos;i="5.49,350,1520899200";
   d="scan'208";a="53323911"
Date: Tue, 1 May 2018 11:05:16 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
        <marmarek@invisiblethingslab.com>
CC: <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH 4/6] xen-netfront: add range check for Tx
 response id
Message-ID: <20180501100516.vjhop37we2rcrvyo@citrix.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <960c6d6300fd3450ae9fb1de1c412bef7dbae992.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <960c6d6300fd3450ae9fb1de1c412bef7dbae992.1525122026.git-series.marmarek@invisiblethingslab.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 11:01:48PM +0200, Marek Marczykowski-Górecki wrote:
> Tx response ID is fetched from shared page, so make sure it is sane
> before using it as an array index.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>  drivers/net/xen-netfront.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index 934b8a4..55c9b25 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -394,6 +394,7 @@ static void xennet_tx_buf_gc(struct netfront_queue *queue)
>  				continue;
>  
>  			id  = txrsp.id;
> +			BUG_ON(id >= NET_TX_RING_SIZE);

It is better to use ARRAY_SIZE here.

Wei.
