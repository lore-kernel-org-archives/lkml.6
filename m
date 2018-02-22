Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AH8x2267ZCBZQIXJaApxUM7wy1S2ggzjWp/QpEKEbhAw8Ber5lWYwuQ4PKamSDFTeZwn+l7FGv8d
ARC-Seal: i=1; a=rsa-sha256; t=1519271240; cv=none;
        d=google.com; s=arc-20160816;
        b=VSh9Of07rjvpAzqGKq0hC3YiBBrZidpBfLeMXjsisdwVvfjdrjr/psOmIoxnKd1kwN
         4HgDZLwayLTdnS0Po3JLcjGTlnQIlDUlPYLHXRIFUPrPxKRUG+/hb/301GinNwoiHDn6
         RKLcDZ4ST1rJOl7gUgNdqkSQV3qBcJgfIJ30KqFIaybv7ag3n/dSVuexAT6yUBmA/mNe
         KpDuc0R6YdX7HwVY7SqGRMtb2qZSW6QCk7AMRKNjsLCWxKPH84CQDb/RjZ1bqyF1jiuj
         +lHD2H9Fo1LUiu2b85C3vlluqlZNsHdMnHKM2yhpdEVnHf0cph+RjrpaaYnvVRyFpXt1
         YFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=cwa8zzkms05CHJQPMErAGhKL70jGiAOcRJjMFNyudn8=;
        b=uxo6rqUEovzwG5MTmTmoHA64BNG6n2VZTD4xckvy/eCbb7ZLZnITKlFjTAB59s1pPd
         qGY4ep6wyDY/Nr196UrpEN/0LA0pZZHh2auC9eC0/vSxwzgtZu58z497iTLPwC6FNlcK
         uhUJp20yFY6IlzJusf4VzzeQM8P6sJoEGuDXFxInnO4WLMXyB3qd+o5wd3wel0402+/q
         iTvkhbEbiwnyuyanP4vwUIvFn1MZ5KGfAROPNtumb3ySiv5veiJivwp0jmbg8ndkTHp4
         1TI+Z31aL65GrqhU/3Z61odkvqlkLj3l+dGykNwCZF8RyXogS1SgKw7kZZc5B47SWABG
         Pgnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
To: Balbir Singh <bsingharora@gmail.com>,
        "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <1519255934.2867.3.camel@au1.ibm.com>
 <CAKTCnzmmUGPNk1ggpWYQjiDLcAR_c7cqdZyPU+6rKGC6AcNW7A@mail.gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 14:47:11 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKTCnzmmUGPNk1ggpWYQjiDLcAR_c7cqdZyPU+6rKGC6AcNW7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022203-0016-0000-0000-00000528506D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022203-0017-0000-0000-000028646733
Message-Id: <76092e30-6959-942c-3600-95fb933eada8@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220048
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593071360484087360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22/02/18 14:41, Balbir Singh wrote:
>> Setting it to 0 is for the reader, not the compiler. I'm not clear on
>> the benefit of starting the version at 1, could you clarify?
> 
> How do I distinguish between version number never set and 0?

The ioctl won't exist without a version number set.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
