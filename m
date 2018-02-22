Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AH8x226S76A33jf2RudYWOb9cUThScyuX2k6XXMdpP1+X7omk8OUNSqDTdwesu77ARwHbJse37Aa
ARC-Seal: i=1; a=rsa-sha256; t=1519271521; cv=none;
        d=google.com; s=arc-20160816;
        b=RZCRcGzXH1v5dHBphgULV/62wQ3dULUevK8LX1pUo6RAfpWGux+hmJ3/5z/CP/IQAJ
         ATPEs4vlo4sYgzeELBzB4YNApTB7s7L417k8a/4MyIUknUkz6gikIZW9EIMmtFS8+TPW
         PVouDSFgCLVodUkwgO0sk1hXuU1jOg7IBPkwta0dgr4Z3U57ZxyjBTersCBmPdh/1eiS
         LOIcDniQddxm2Y59NCNhwU8xTteCOX9eF0CqpRBDgxWpga9+I9ml21hLUhhBpQgjEdTm
         pLHwLAv4bZ6xnyafbx0axtmL+op/lHsouz6DNNMvwabn6rvJvUU6yizprJSAT9dT0kLH
         GU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=zwO/HHOr3JLDIG42x0LtQ0kDX/hGJHpqpq/1iK1tc4w=;
        b=gz0vo2VXwILcbOvJS29E+34Tg7YyIzfc9YGONeJCuypRG9JFSumOXh0Yo51Jh4umPV
         uqXu6cPBpBP2VCIxGzkKhn+GiKbCNaTJUcqD5z0ZxLYbSlvKb5IqbhzVMpn37zM+ktAJ
         28nOKL5X7Jk8/wn9duVrDjTFRfJKeKJ2T1FiWJ1b5KWws7xHMZVoQ9Ldnyey0vCykB+E
         /dLU5T+8EY3MrKRRrACjsfWpmufuft+eWtLAckdlC6BUoRX+2JXQy7TTt9G50FgKhxoD
         72slq4QM44x5kR7S2o4U/qYdNEZ4QGeaqJDlLYJ5WiJjfn7Q8mpc663g8mfGtvxu/nLN
         Ks0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information
 to userspace
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>,
        Frederic Barrat
	 <fbarrat@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
        Greg KH
	 <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 14:51:52 +1100
In-Reply-To: <CAKTCnzkwwmbU4vzrmzW=eNnr2QW+rj=OUcAdOVxz+qKGC=9Q9A@mail.gmail.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
	 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
	 <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
	 <CAKTCnzkwwmbU4vzrmzW=eNnr2QW+rj=OUcAdOVxz+qKGC=9Q9A@mail.gmail.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022203-0008-0000-0000-000004D2FCE6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022203-0009-0000-0000-00001E66073C
Message-Id: <1519271512.2867.14.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220049
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593071655174191617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-22 at 14:46 +1100, Balbir Singh wrote:
<snip>
> lpc_size could be added. It's currently useless to the library, but
> > doesn't
> > hurt. The one which was giving me troubles on a previous version of
> > this
> > patch was the lpc numa node ID, since that was experimental code
> > and felt
> > out of place considering what's been upstreamed in skiboot and
> > linux so far.
> > 
> 
> Yeah, I think metadata will evolve for a while till it settle's down.
> Since ocxl_ioctl_get_metadata is exposed via uapi, a newer program
> calling an older kernel will never work, since the size of that
> struct
> will always be larger than what the OS supports and our
> copy_to_user()
> will fail. The other option is for the user program to try all
> possible versions till one succeeds, that is bad as well. I think
> there are a few ways around it, if we care about this combination.
> 
> Balbir Singh.
> 

We have a number of reserved members at the end of the struct which can
be re-purposed for future information (with a corresponding bump of the
version number).

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
