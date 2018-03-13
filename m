Return-Path: <kernel-hardening-return-12502-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELudufFdLc2ycCdP6VTGusRee8FMZ6s/EsrodvIitpGHgmytwdc10ynoynj5Y9Bpm0AtU48A
ARC-Seal: i=1; a=rsa-sha256; t=1520940839; cv=none;
        d=google.com; s=arc-20160816;
        b=Z7ZtX60iSR4P5kEineiNcB1iTUtwn+6ndtTuqtX3lq+bU8e4kacuCSWdwOr4FSVYNH
         dRYyqJmky6ticjzKxU94DUlSYOYNm5NSfaQ3MFhVnBAojv75ZBh7XXHn5AGyb03uPldO
         Zdaxk4Rg0rzmq33UW4L9NAiXV6Es9lp72RHLDRBMAfE/6s8FTMp2DyNYZupdt1w4NIg6
         LCbYfQL4sh5umVrs8bnogzOEUnV6vEzXjPyO3m+djO0t6bI8D4ZlTQyT/gQAXr0P8aA6
         6wTLtLW+rdllW40gMDqrUHxsJKiPo5YJZMH6IFm5NEFHQN0lUl/tq3dcaQff6aKBeWnj
         7TXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=bwmNZSK2OFCGeOIhdXwdfIPkt4Th8EFmOUgkt5eZc3U=;
        b=hEv2vKMdSMC8OdwiWrLtE6pJ6au6bfRuappSdl+lCgil+3jP4DT0JOrTimJRZ9NWwC
         NF+oO4n9oiLp3xL4chzj0H+5TV+OPiC+njsL0vv541UNLAEBDyFTRwedvN5hjWkoWIWk
         CbvINpJy3SEOD8xdswTbbJkZz9GewIEIf2aGRPFaWwW3ah9I2BEooITz5h36Ksdohmvy
         XUprxr0F8hDZvAA8d70LugC8R2jUhKXIAzSPNUVS9Rd7+MBCcBosOPvF3QLJZQRR/XbF
         WFKrbMWvqbOXQhMYVOorzQwIG8+SYXLGyIoE6RyAKwxIGIO4qTg/x40GfIuXXc2PfJwb
         QY/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12502-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12502-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12502-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12502-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stephen Kitt' <steve@sk2.org>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "jejb@linux.vnet.ibm.com"
	<jejb@linux.vnet.ibm.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH] scsi: resolve COMMAND_SIZE at compile time
Thread-Topic: [PATCH] scsi: resolve COMMAND_SIZE at compile time
Thread-Index: AQHTt/bqFPEiuDS4SUu2kXmgJWeSEqPODPRw
Date: Tue, 13 Mar 2018 11:34:31 +0000
Message-ID: <a66f8abb84444cf79b818011667bc825@AcuMS.aculab.com>
References: <20180309232933.14e39858@heffalump.sk2.org>
 <20180309223355.21222-1-steve@sk2.org>
In-Reply-To: <20180309223355.21222-1-steve@sk2.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501214170730131?=
X-GMAIL-MSGID: =?utf-8?q?1594822061211484979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Kitt
> Sent: 09 March 2018 22:34
>=20
> COMMAND_SIZE currently uses an array of values in block/scsi_ioctl.c.
> A number of device_handler functions use this to initialise arrays,
> and this is flagged by -Wvla.
>=20
> This patch replaces COMMAND_SIZE with a variant using a formula which
> can be resolved at compile time in cases where the opcode is fixed,
> resolving the array size and avoiding the VLA. The downside is that
> the code is less maintainable and that some call sites end up having
> more complex generated code.
>=20
> Since scsi_command_size_tbl is dropped, we can remove the dependency
> on BLK_SCSI_REQUEST from drivers/target/Kconfig.
>=20
> This was prompted by https://lkml.org/lkml/2018/3/7/621
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  block/scsi_ioctl.c         |  8 --------
>  drivers/target/Kconfig     |  1 -
>  include/scsi/scsi_common.h | 13 +++++++++++--
>  3 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 60b471f8621b..b9e176e537be 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -41,14 +41,6 @@ struct blk_cmd_filter {
>=20
>  static struct blk_cmd_filter blk_default_cmd_filter;
>=20
> -/* Command group 3 is reserved and should never be used.  */
> -const unsigned char scsi_command_size_tbl[8] =3D
> -{
> -	6, 10, 10, 12,
> -	16, 12, 10, 10
> -};
> -EXPORT_SYMBOL(scsi_command_size_tbl);
> -
>  #include <scsi/sg.h>
>=20
>  static int sg_get_version(int __user *p)
> diff --git a/drivers/target/Kconfig b/drivers/target/Kconfig
> index 4c44d7bed01a..b5f05b60cf06 100644
> --- a/drivers/target/Kconfig
> +++ b/drivers/target/Kconfig
> @@ -4,7 +4,6 @@ menuconfig TARGET_CORE
>  	depends on SCSI && BLOCK
>  	select CONFIGFS_FS
>  	select CRC_T10DIF
> -	select BLK_SCSI_REQUEST # only for scsi_command_size_tbl..
>  	select SGL_ALLOC
>  	default n
>  	help
> diff --git a/include/scsi/scsi_common.h b/include/scsi/scsi_common.h
> index 731ac09ed231..48d950666376 100644
> --- a/include/scsi/scsi_common.h
> +++ b/include/scsi/scsi_common.h
> @@ -15,8 +15,17 @@ scsi_varlen_cdb_length(const void *hdr)
>  	return ((struct scsi_varlen_cdb_hdr *)hdr)->additional_cdb_length + 8;
>  }
>=20
> -extern const unsigned char scsi_command_size_tbl[8];
> -#define COMMAND_SIZE(opcode) scsi_command_size_tbl[((opcode) >> 5) & 7]
> +/*
> + * SCSI command sizes are as follows, in bytes, for fixed size commands,=
 per
> + * group: 6, 10, 10, 12, 16, 12, 10, 10. The top three bits of an opcode
> + * determine its group.
> + * The size table is encoded into a 32-bit value by subtracting each val=
ue
> + * from 16, resulting in a value of 1715488362
> + * (6 << 28 + 6 << 24 + 4 << 20 + 0 << 16 + 4 << 12 + 6 << 8 + 6 << 4 + =
10).
> + * Command group 3 is reserved and should never be used.
> + */
> +#define COMMAND_SIZE(opcode) \
> +	(16 - (15 & (1715488362 >> (4 * (((opcode) >> 5) & 7)))))

Why not:
	(6 + (15 & (0x446a6440u ....

Specifying the constant in hex makes it more obvious.
It is a shame about the 16, but an offset is easier than the negate.

	David
