Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZryk/i/+zd1i1iRINKl1rM+xlOgWjliksjvVnBXOBT4rKpXO5XfXefr6w9x6vPmfQIAmHw0
ARC-Seal: i=1; a=rsa-sha256; t=1525751680; cv=none;
        d=google.com; s=arc-20160816;
        b=D/AcO4eBDKMB19IRWJaP/5F6od1UHvwLCa7pIF1Y6GLKwxP1ChoMlSSOCCVk2M6SGV
         QANuTDKTfCN5lMcpqqpAgE1+zLGVe7vJe9Wq+q9+2h325LL7aIs8rGnWlZJxRvYn4LNh
         q7nnuDqtH6/BpupctiWH6mhE9LYc4GVYkuntm7l/PzJ7z5KfHljrWsbbnvFCpDLRXeWg
         YZmReKkOPZqtvJpvT9did5n0lOnkCHHteN4uTjmcO8gcKuVXZ4s1ifXeOS0D/N1bTMXO
         HXR1IKTqg4iZ84UBktBPrNjXGdrY0v0cjIDG6wzTwRHrxuArIJORrwccjBgmLYY8I1Yi
         8OCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=GmcHAaqMMvC+GT5Mgm9ftPeonc9wWOWYwY0VfCPnOVw=;
        b=LHo41WH3sj17xlqbiolsiuU9bd2WYdbZUX2iMelbwDCasdEzwu5Lbaw50xZr8eioTt
         dulOs/oAcNp9RxLxJGNB78BJ8a9Z8/zUv1F5u+3N8yXRlqVrzMIfWPBxA8JuDLYXOi72
         psVIGtByY7Opjqj2k3xUv4Qe13mqr/5vGEA9psDIjn8YGGgwXASDR9c++acuZxmDu4Bx
         CiAqW27nrQ51N+/zEIyWmiC/jmKK10CrHWLcOgaG8ZWccBx+oDk3aMDU663Wsr2cYokV
         w4uI0VWf61MUnIVGohBV1EtPNfHARsFb7IhCVGV5HN5LNn88W/Hz8LKUd6WImBCK9dAO
         /Yjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU
 features are available
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
        felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net
Date: Tue, 08 May 2018 13:54:31 +1000
In-Reply-To: <20180508135019.3e08d57a@roar.ozlabs.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
	 <20180418010810.30937-1-alastair@au1.ibm.com>
	 <20180418010810.30937-7-alastair@au1.ibm.com>
	 <eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
	 <1525740115.7796.46.camel@au1.ibm.com>
	 <20180508135019.3e08d57a@roar.ozlabs.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050803-0012-0000-0000-000005D3CDFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050803-0013-0000-0000-00001950DB2A
Message-Id: <1525751671.7796.49.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080038
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598044369272237673?=
X-GMAIL-MSGID: =?utf-8?q?1599866594231527293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-05-08 at 13:50 +1000, Nicholas Piggin wrote:
> On Tue, 08 May 2018 10:41:55 +1000
> "Alastair D'Silva" <alastair@au1.ibm.com> wrote:
> 
> > On Mon, 2018-05-07 at 20:14 +0200, Frederic Barrat wrote:
> > > 
> > > Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :  
> > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > 
> > > > In order for a userspace AFU driver to call the Power9 specific
> > > > OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can
> > > > actually
> > > > make that call.
> > > > 
> > > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > > ---
> > > >   Documentation/accelerators/ocxl.rst |  1 -
> > > >   drivers/misc/ocxl/file.c            | 25
> > > > +++++++++++++++++++++++++
> > > >   include/uapi/misc/ocxl.h            |  4 ++++
> > > >   3 files changed, 29 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/accelerators/ocxl.rst
> > > > b/Documentation/accelerators/ocxl.rst
> > > > index ddcc58d01cfb..7904adcc07fd 100644
> > > > --- a/Documentation/accelerators/ocxl.rst
> > > > +++ b/Documentation/accelerators/ocxl.rst
> > > > @@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
> > > >     Obtains configuration information from the card, such at
> > > > the
> > > > size of
> > > >     MMIO areas, the AFU version, and the PASID for the current
> > > > context.
> > > > 
> > > > -  
> > > 
> > > 
> > > Intended?
> > > 
> > > Other than that,
> > > Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> > >   
> > 
> > Nope, I'll fix that, thanks.
> > 
> 
> Just to be clear, this is for OCXL features. I would just make that
> explicit in the title (s/CPU/OCXL).
> 
> Thanks,
> Nick
> 

OK, sounds reasonable.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
