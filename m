Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AIpwx480egSafwqPRAko4iuQtwM6tqVXtgvavoo19FjiwUyPyaACrsWCACgsCRYbJ7DM7Q4QE/0+
ARC-Seal: i=1; a=rsa-sha256; t=1524009097; cv=none;
        d=google.com; s=arc-20160816;
        b=o44+MIZFeDXkoGKXtOQlUwDMPHXp8BNHcb5ritR+BKU6jk8q1MHKPHLfAIeYilf8MX
         fJoMx0weiuy3WhAbMbrVndF6ILEkr6t+WiVDyZeNUZ0dPG7PJPXTQjOv4CF5aXx4vYxS
         Nwll0IkNu0eNdeHOYwzcV2DjEStmOhVSTSeNuxWsXv5LS5RyVZWVWAGz3DBKpKdzk/Px
         pe7UxNrn9mRL3m7KIlGyV8qcaEEvv+3w3FNe2ZC9hiTu5BhQUj9IHO18+/WaVfs5kmH9
         wLB6VwG+Im+5UqRd/ZI/HQQbqocMAXVMVi6Fc7+0yZxt+icYutMrzoG2LCt2bHQJiCbd
         uO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=GPURw3QN9bQaSLcU6o4Fck5xhxaegaWb3kQo0LFXmWc=;
        b=CHhtmyTjHHSPSpu+NExs25I93l48Iag5RJqJHSbKwS82m2V/XrMYBtNtB81Ge4D6zZ
         cWAr7p3U/NaDnjVQ+ylD8MR03GB4Rje0yvN4cHBuJ9bd7CLwMxcc5Ara4WWLXQTIoxin
         ldigFV37SjT3HbdDgzygCNZBFBM0wt5r0fv5vL/BUJp5bIA8mpBm8kbj0gacQ7kMEpDD
         nU4AEosL7oW8ssyCLzZqKTRzkvvW+L1WhhrJj3XdTSrWQG5cNnNLKa0cRcdK4BVb8rnH
         8mzifIF3Ji3L23nneKEC+72HDAAB+i+ETM3n13Nlwa4qcZyOUsCwn71EWEA6XfgFOU+R
         M1GA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] misc: cxl: Change return type to vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>, fbarrat@linux.vnet.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
References: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 18 Apr 2018 09:51:27 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041723-0040-0000-0000-000004302257
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041723-0041-0000-0000-000026342F99
Message-Id: <384a35d1-30dd-55d1-4a19-d7c9dc99bdfb@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598005414798688515?=
X-GMAIL-MSGID: =?utf-8?q?1598039363533169432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/04/18 00:53, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")
> 
> previously cxl_mmap_fault returns VM_FAULT_NOPAGE as
> default value irrespective of vm_insert_pfn() return
> value. This bug is fixed with new vmf_insert_pfn()
> which will return VM_FAULT_ type based on err.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

This looks good to me

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
