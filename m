Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZp01QfK21bsVI2BQ4NHIzt7KPdjfOA0tOVdgxKTkKgOgA0t17/OqJeoqK6MvYF5cCe/xiX3
ARC-Seal: i=1; a=rsa-sha256; t=1524734744; cv=none;
        d=google.com; s=arc-20160816;
        b=viIjNsUcskeZnTpz5r63aiehRiU1ycRLD/sEzLNy4/h8k16XUmRr7pz9S57gkP+pFI
         1wUaCMEUHLW2I54kG5YQvMgHrxZd5eAT1ruAifcRXtkjnDtu7ivHaq3v/UcVTNTcgipP
         JVTpNjgpbCkWFTEZnRZVD9S11KHTyHRKKsVBic9YkT80dPSKaOznkwXJ58J6KZQEsykG
         LnWLrn8nluTD7gHq6VRPNY7qJTXZNCsCatc8wP+TsjdsApvdefwmTFRBXyXP+5p/TmtQ
         QbY5M0M89mvzz5lfwPT9XOr3i5pdtV7CMqR3J7YYOBBc0dUXWGAOZ4fFxiD3WSljkFJd
         S4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=vrw6D8BPUqNI5lfd4P5C7cE28+Cm01JyH1e0x5xNKNE=;
        b=Irngd00R8ojrl34Z9DMKpfVkRw16ZUmF1xFLqjtG3aI5vCeEPT8K3ytU0JABb9KYZ6
         7mcZE2D91/a7Feh775ovXln1CMItiAbg68jN/niXkrKhNMrtpCOAC60HYRwAokgfNlCh
         Hb1mBE9nNccK5QS8FD9atzsQ7LvCHhsyW4jyxx4543MHMJnmXhLDOeTGeT4DKN2lT3WM
         bGAv/pVFwafVW8iqU9QxxMxYpxzzOj8/YRLCIzHaUVY85kvZ80hYe8i8HAnKiIwJN5IP
         T8KLL6Xmt47453eeASLl+4IEj9m/gnxOiGzxV5LAjxl1s3pzIVg4KUovGqvLr7f9jjd8
         3IaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 3/7] powerpc: use task_pid_nr() for TID allocation
To: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Cc: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mikey@neuling.org, vaibhav@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, malat@debian.org,
        felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-4-alastair@au1.ibm.com>
 <b088d063-058a-2557-812c-6d5659f9d67b@au1.ibm.com>
 <20180424211231.GA25392@us.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 26 Apr 2018 19:25:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424211231.GA25392@us.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042609-0012-0000-0000-000005CF43B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042609-0013-0000-0000-0000194C4850
Message-Id: <c793bf59-5670-e01c-fe63-903844650991@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804260091
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550726280592?=
X-GMAIL-MSGID: =?utf-8?q?1598800259985755515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 25/04/18 07:12, Sukadev Bhattiprolu wrote:
> Yes. Like with PIDR, was trying to assign TIDR initially to all threads.
> But since only a subset of threads need/use TIDR, we can assign the
> value later (when set_thread_tidr() is called). So we should be able to
> use task_pid_nr() then.

OK. Alastair has also confirmed with me that truncating the pid to a u16 
should be safe, so therefore:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
