Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AG47ELujpw8+m3GBrSwIN+LD/Ue7ZIyQY4ZMKsRdL2zdOTMGWpsmfxAgOLJMb327ovXkcjxvqrXx
ARC-Seal: i=1; a=rsa-sha256; t=1519256272; cv=none;
        d=google.com; s=arc-20160816;
        b=A6RjxMC1qQ4D1qy+B6Sex6rTDKD/ZBOtOj6n3yJ3p/zFeSW2Afr0pcGA2USJnsjVq1
         BLsSfpuQFSLuqkqGRGNogDq8F1EF+TKZv6hS9Lu5BgAPcjGIhyqXgGBOuoLBrwnJ8QP4
         43dOHi4VLrtFF99tYu1jYdGjGBeKfj7LO1BcXBUQVL0Uy/exaUJkvxpLvas14KK6xwjZ
         Kt8TmphsUWA4qwzdNXptQMIbCCCG4a3ipi/ebf3KkrDJAsVRmjDl6CMztukd2SWSymBH
         3rbqVkWNwAIeqEXt9TnPzyOjhpq63u3zeZfoy2gHtARGOHy1sCofGQKU1t4UnSdpZ9Dl
         r5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=OH4cM190tcMSH6n9WIpFVBOzKnmjxW0FrFiHRnUtod0=;
        b=x0RJ1bm71YwxEl9ENzJ6UHg/BciHnVrY0GVQllnGHqv1LuFQdOHmkWkDXkBKiEilrV
         OXWO3PCvqit2/ZeVtO9F30zJoVrmJXhWEjST5Kc+nXawRYvjcNeQ1enaQJTb1oNdnd+8
         OGJb7vEUQ/HH79iimaajDlc29HbtgbhE4O06awErBNZ0+PCLxn+Q8YOuB8LuSapoBe+M
         +tVzcba0iwuByaatvGLH7Cyq6DX21N4UKQqja7NPNRc8USG7LAnPqYakVV3UaNv+lf2t
         JM5ess1l+Plcx1TA0D5YXXP5fuzl9uOvEbPd3BXP3WQIEHFaRafxQkYsSoOF1E20Jixa
         3gsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information
 to userspace
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Balbir Singh
	 <bsingharora@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
        Greg KH
	 <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 10:37:43 +1100
In-Reply-To: <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
	 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
	 <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022123-0040-0000-0000-000004153A7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022123-0041-0000-0000-000026184D9C
Message-Id: <1519256263.2867.8.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210279
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593055664602781718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-21 at 12:25 +0100, Frederic Barrat wrote:
> 
> Le 21/02/2018 à 07:43, Balbir Singh a écrit :
> > On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm
> > .com> wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > Some required information is not exposed to userspace currently
> > > (eg. the
> > > PASID), pass this information back, along with other information
> > > which
> > > is currently communicated via sysfs, which saves some parsing
> > > effort in
> > > userspace.
> > > 
> > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > 
<snip>
> > Should we document the fields? pp_ stands for per process, but is
> > not
> > very clear at first look. Why do we care to return only the size,
> > what
> > about lpc size?
> 
> My bad, I forgot to mention it before. There's a somewhat high-level 
> description which needs updating in:
> Documentation/accelerators/ocxl.rst
> 
> It doesn't go down to the level of the structure members, but at
> least 
> all ioctl commands should have a brief description.
> 

I'll update the docs.

> lpc_size could be added. It's currently useless to the library, but 
> doesn't hurt. The one which was giving me troubles on a previous
> version 
> of this patch was the lpc numa node ID, since that was experimental
> code 
> and felt out of place considering what's been upstreamed in skiboot
> and 
> linux so far.

I'd rather add the LPC members when the rest of the LPC code goes in.
At the moment, the LPC size represents the window size (as a power of
2), whereas we expect that it should represent the actual amount of LPC
memory exposed. I would rather avoid changing semantics of members in
released code, or burning another reserved member for the updated
definition if we can avoid it.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
