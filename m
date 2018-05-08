Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZoRv4zY00Pc8fcnNtrBFn2DCCRiFrvbCkZe+sb770Rul8TmyX5uYGxQrj7S5Q1bZRkOdzyl
ARC-Seal: i=1; a=rsa-sha256; t=1525740124; cv=none;
        d=google.com; s=arc-20160816;
        b=uTJXa0Kykq5/Wi2Lb5yHnoOyPLQk24rus8LPQ4ZDav+RwWaHPD9geRSTglebnT+VYK
         SQbuN0k36AXVZTPfINMwF0pL6kgiAbBwluTREzKgsimfVS30CH+Upl25LiHcmrau5JiO
         dqB615euNFHGp4JZWTImb99KuBkjqucQ4gCpw6N1zICkZatVm7ZQv3oht0O3bBBRHM0Y
         80Afkjbwc3PWqi/NiLIegkwp2FEEt7u/wWxO8lJX7Tye1yA9VWxG/SFityosXoQj8meI
         OsvkYUDTpPGmyt61GQyR9LRGqqbKs7YLQNH6xSSf5v7YfQ71sXJM39ZVppfswAETeHcU
         MIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=6pRfv6b5e/exxd2d94+/JrRU/vi4KMMmhrgkF3Ldh+o=;
        b=n/rUByVct7grxoAoDVcSCz8EjWI4MHwlP6I51N5KivOKW2qyWB8ASIELs7hvt+u6HT
         gE2UXmMkiBQnczSZkr3Jm5AR40BLOq8/aO6xJnDXqi9dH0o9rT39J17DOmun6VQ5g8Ea
         DpG2TEIFNXerXRzkhrpoXevi9RQrTGL4Mar4joGa6WYzjbgwS3dkPGnHAA7HRxDaBP+F
         bpg6C90gUo2V6cse5r3o0TgC/tPf2nuwc0xY5ARM+tDSBdnHe569NETDOWIL64p4JWLa
         y3MwOghZSHjDHJ/sbBrSoWrl7kJ8Y1+tC01XOJjivj4trL5tsakXRkPMb7T7TA0ahGxu
         2NpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU
 features are available
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net
Date: Tue, 08 May 2018 10:41:55 +1000
In-Reply-To: <eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
	 <20180418010810.30937-1-alastair@au1.ibm.com>
	 <20180418010810.30937-7-alastair@au1.ibm.com>
	 <eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050800-0040-0000-0000-0000045717B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050800-0041-0000-0000-000020FB18D7
Message-Id: <1525740115.7796.46.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080004
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598044369272237673?=
X-GMAIL-MSGID: =?utf-8?q?1599854477417878763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-07 at 20:14 +0200, Frederic Barrat wrote:
> 
> Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > In order for a userspace AFU driver to call the Power9 specific
> > OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
> > make that call.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   Documentation/accelerators/ocxl.rst |  1 -
> >   drivers/misc/ocxl/file.c            | 25
> > +++++++++++++++++++++++++
> >   include/uapi/misc/ocxl.h            |  4 ++++
> >   3 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/accelerators/ocxl.rst
> > b/Documentation/accelerators/ocxl.rst
> > index ddcc58d01cfb..7904adcc07fd 100644
> > --- a/Documentation/accelerators/ocxl.rst
> > +++ b/Documentation/accelerators/ocxl.rst
> > @@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
> >     Obtains configuration information from the card, such at the
> > size of
> >     MMIO areas, the AFU version, and the PASID for the current
> > context.
> > 
> > -
> 
> 
> Intended?
> 
> Other than that,
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> 

Nope, I'll fix that, thanks.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australiamob: 0423 762 819
