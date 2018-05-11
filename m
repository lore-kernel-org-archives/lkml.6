Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AB8JxZqQKL3aij4J1bLz0R9QTetjU+9pyfgctaNhDJkpweBlPoB+OugT3DisfvHPMaG6o1nwSDoV
ARC-Seal: i=1; a=rsa-sha256; t=1526014906; cv=none;
        d=google.com; s=arc-20160816;
        b=lBoeU2T/xI0lnl8ciGzB4zVOoRv09xiHTKsc8kBEZRBkHOYbWGhGckQWPsN17iWGUL
         Ue6DSWee2LxwFGHNAXhyrMV8ezVmoMKgIoubVFWRKs2y+o2epddHuwoVHKWMY+g6IORG
         3uFMWob7M6YJyhC4Yik6frlGHy0D16oKb9UqxOQ6RNtRHDqzNHRjL3VehSkGwJ8eURiH
         mhws1cq5NJwlORUSmlYuREw7vzSw1I2BRZaFGv4Qpr04HWHTkj646gGk90X1y2yDY5rQ
         7VxKB4B6t4f/9D4H17tQCuw8b2COvZHqa9wFwLRGcr8cx4vTZ76Gj1MROoDR+TqD8UTg
         W0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=B+u94bEDmiIOO4wFgQzfjdyZa92TXW9mmPi/h3Bbroo=;
        b=SKXVy8FTe0xLwZz4dSYd8cTXXXcHWqddj0npWnfQcFBqVkiHr/66sDUGzGavW1SXKQ
         zGhuN3yvH+GJTYdjfiXWqxSOuUiVHjbIt6H11m7F/KOuf9pJs7sytMFav/YuQWfJvGhM
         UdHNPHdOcqa0UEW7JLshYLWccAEIfTaYNWWykYVUE/8Ch15v1256+HlSn32xeclh9Vj/
         uqGm84jAGZ7yXhkmwm0PdGKcZHAOKECv8Jc5Ecupnires/AFK5OSvs/InsHOJY2pub/5
         tSlBQlEvUZwvS+r68uuLkW8mHLkppvS5mnMW5yprRivc0NRB5L3xh730TeWMGdnNDO7P
         hxVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alastair D'Silva <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, arnd@arndb.de, linux-doc@vger.kernel.org, malat@debian.org, gregkh@linuxfoundation.org, corbet@lwn.net, vaibhav@linux.vnet.ibm.com, npiggin@gmail.com, linux-kernel@vger.kernel.org, fbarrat@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com, pombredanne@nexb.com, felix@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v3 5/7] ocxl: Expose the thread_id needed for wait on POWER9
In-Reply-To: <20180509004212.4506-6-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com> <20180509004212.4506-1-alastair@au1.ibm.com> <20180509004212.4506-6-alastair@au1.ibm.com>
Date: Fri, 11 May 2018 15:01:35 +1000
Message-ID: <877eoass40.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599945148775984066?=
X-GMAIL-MSGID: =?utf-8?q?1600142606574596397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Alastair D'Silva" <alastair@au1.ibm.com> writes:
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 0af83d80fb3e..8d2748e69c84 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -48,6 +48,15 @@ struct ocxl_ioctl_metadata {
>  	__u64 reserved[13]; // Total of 16*u64
>  };
>  
> +struct ocxl_ioctl_p9_wait {
> +	__u16 thread_id; // The thread ID required to wake this thread
> +	__u16 reserved1;
> +	__u32 reserved2;
> +	__u64 reserved3[3];
> +};
> +
> +};
> +

O_o

???

cheers
