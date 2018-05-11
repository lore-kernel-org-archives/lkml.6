Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AB8JxZp2BiLZaXLfn9s2oxon1O+7T0BNHYW0fRZ7RgUd34oAN0krnOvAHP4AD9TqM09EcFzWlNmV
ARC-Seal: i=1; a=rsa-sha256; t=1526016025; cv=none;
        d=google.com; s=arc-20160816;
        b=z4nmOjxvqWEI+C41bHfYFg2kquZvctuZGESF9gh06dcFvSyf6lgow8rKPZDyP+WQui
         NNhfu7sHUuSvppbSKCKeFQ7zoozfME9606DASKvt4jTNB9jF7IFR2GuqARfGB/+IgG/M
         nS6ZFxER2h4nAIm3+p/K4fI8X5IzoJD21Ila/EFi/BG1S8phxSNpWHULYBB6BtIWdKXW
         ru3BiUK9XXhvh50ie6ERE1138Z3kZHR3qdP1VTuS5lJVOthHjOvrgYDVS/OgWAyFApl7
         gMwWkzqNHCEaS0eWzlSJjdqu+Zn/Gwl9We78lZ0fUCx6nuQ1TKZKJGErFwTMUMPM119u
         8pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:arc-authentication-results;
        bh=rgUDXDWkRcrVSHxak9s7hNvIqC4rksW8Rh7oQREUpoM=;
        b=DqffhfV0vyz6DMNhCRP2bl5v99z2EHOO0lLydC4xEIKoRgjKQJFJugLtojPgHatazL
         g/C17yyrLlYrd4zw5ozrFQZg5hCUTW4pFw5PGjNpPPNdS55Iu25Xkhd2hX25a5gbaQ48
         dC+4c1JX44d+u4NuRq0kruxJ5HgBYLg7MiI+Ficm5P4UdJajkwO2/byHaeRYZbItnezA
         2CHtpE4UAUYfYpIgVRzMlHdoZoJCJuyexenTh9wZRVcVTD1cIOya3oHcv/oXx52sgqbv
         kx7GBF5SpzNJsB7bpau6yM1MTP42n9PO8ccT41bWMFNKUlQI2RrfJGBro5b7U9Uj+04d
         0R5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alastair D'Silva <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, arnd@arndb.de, linux-doc@vger.kernel.org, malat@debian.org, gregkh@linuxfoundation.org, corbet@lwn.net, vaibhav@linux.vnet.ibm.com, npiggin@gmail.com, linux-kernel@vger.kernel.org, fbarrat@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com, pombredanne@nexb.com, felix@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com, Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v4 6/7] ocxl: Add an IOCTL so userspace knows what OCXL features are available
In-Reply-To: <20180509053506.9754-7-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com> <20180509053506.9754-1-alastair@au1.ibm.com> <20180509053506.9754-7-alastair@au1.ibm.com>
Date: Fri, 11 May 2018 15:20:21 +1000
Message-ID: <871seisr8q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599945147498054809?=
X-GMAIL-MSGID: =?utf-8?q?1600143780473327073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Alastair D'Silva" <alastair@au1.ibm.com> writes:

> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 8d2748e69c84..bb80f294b429 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -72,5 +75,6 @@ struct ocxl_ioctl_irq_fd {
>  #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_i=
rq_fd)
>  #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl=
_metadata)
>  #define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioc=
tl_p9_wait)
> +#define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl=
_platform)

I don't have ocxl_ioctl_platform ?

../include/uapi/misc/ocxl.h:78:56: error: invalid application of =E2=80=98s=
izeof=E2=80=99 to incomplete type =E2=80=98struct ocxl_ioctl_platform=E2=80=
=99
 #define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_p=
latform)
                                                        ^
../include/uapi/asm-generic/ioctl.h:73:5: note: in definition of macro =E2=
=80=98_IOC=E2=80=99
   ((size) << _IOC_SIZESHIFT))
     ^~~~
../include/uapi/asm-generic/ioctl.h:86:56: note: in expansion of macro =E2=
=80=98_IOC_TYPECHECK=E2=80=99
 #define _IOR(type,nr,size) _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size=
)))
                                                        ^~~~~~~~~~~~~~
../include/uapi/misc/ocxl.h:78:33: note: in expansion of macro =E2=80=98_IO=
R=E2=80=99
 #define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_p=
latform)
                                 ^~~~
../drivers/misc/ocxl/file.c:262:7: note: in expansion of macro =E2=80=98OCX=
L_IOCTL_GET_FEATURES=E2=80=99
  case OCXL_IOCTL_GET_FEATURES:
       ^~~~~~~~~~~~~~~~~~~~~~~

cheers
