Return-Path: <tmricht@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZo1g/B/XEk5cIq0IKRaP0j5f4wmlzZIOIpXbi0juJVQ15b4pFEdz9CtvVA/1rkIHEP7sBCx
ARC-Seal: i=1; a=rsa-sha256; t=1524828659; cv=none;
        d=google.com; s=arc-20160816;
        b=GJlkmakYyJU1lvFIYGSz+35EcCtQBNqFoK16CIS262oeg3AIVR8ZCdefMThoCrTo98
         iuNswb/9GX3gN+/1c2gMP4XmR5XTcXTacyUPO5acIVGTpWkR20pJJYWLMuIaRcvkKw9t
         c81sHMTOHO//sG5HONKWMO4VpSa6AcaB+mgcESeT5NfQKEN6OwBgf/6wAnVHoiGHcWed
         9E/88ywz663Js5GooZuDfJ1JgJqcQNE1et+FpXsGDFB3REPdOe3UjLa9KU5BDq1ThEOJ
         zNMc4vRVEpkl3LCILman5ndePE0tJF6edDV5+iCGwlmV63no1S+q07qaxbVZ/gyMZG4C
         GEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:in-reply-to:mime-version:user-agent
         :date:organization:from:references:cc:to:subject
         :arc-authentication-results;
        bh=GE2Rl67/VbiqKV84WKH2FM56WT/O8UqNAex/EdL2Bzc=;
        b=06GbJvtJaSS2YlDRgTTphhLTZIr9a4eREO3kB3FrERdONNo+sGXJJoAVonhk9PqK9U
         DUoU5ke7HmJDIbUeFESj/MFmFdRHhPEEORNTcxkmOPMMjB5zHU6jpr1vozNiFEuWyKQH
         WZbUbB3vWuNaGI3KJeNyLBtmHInJ8+MUbJqkZIolI2Iwve/NNDskIrWYxjENA+xLtVqq
         zVTWPVLCsMPZSbQOwUhIQP00DxfW5ukeka3JFQ6fX/RSeEkSS0IMcE/n4a4Kk0+qdc5/
         azz2BCU97f1dxg4hq/rFSq+le9R0mosU6lXepRlr2OYbS7lWa9OuFt7WPTjYXemBnMcr
         DzNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] inode: debugfs_create_dir uses mode permission from
 parent
To: Greg KH <gregkh@linuxfoundation.org>
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
References: <20180427080712.2380-1-tmricht@linux.ibm.com>
 <20180427082737.GA25242@kroah.com>
 <504bade7-7b06-c9d4-e4e2-736b9ee5a313@linux.ibm.com>
 <20180427100600.GB12941@kroah.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Fri, 27 Apr 2018 13:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427100600.GB12941@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------5395A79255F6AB5325A9A42F"
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18042711-0012-0000-0000-000005CFAFE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042711-0013-0000-0000-0000194CBC7E
Message-Id: <82a7c2a7-f8f4-0e59-a770-c3e191f9d3de@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270111
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598885939373348657?=
X-GMAIL-MSGID: =?utf-8?q?1598898736675910313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------5395A79255F6AB5325A9A42F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 04/27/2018 12:06 PM, Greg KH wrote:
> On Fri, Apr 27, 2018 at 11:14:26AM +0200, Thomas-Mich Richter wrote:
>> On 04/27/2018 10:27 AM, Greg KH wrote:
>>> On Fri, Apr 27, 2018 at 10:07:12AM +0200, Thomas Richter wrote:
>>>> Currently function debugfs_create_dir() creates a new
>>>> directory in the debugfs (usually mounted /sys/kernel/debug)
>>>> with permission rwxr-xr-x. This is hard coded.
>>>>
>>>> Change this to use the parent directory permission.
>>>>
>>>> Fixes: edac65eaf8d5c ("debugfs: take mode-dependent parts of debugfs_get_inode() into callers")
>>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>  fs/debugfs/inode.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>>>> index 13b01351dd1c..80618330d86a 100644
>>>> --- a/fs/debugfs/inode.c
>>>> +++ b/fs/debugfs/inode.c
>>>> @@ -512,7 +512,10 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>>>>  	if (unlikely(!inode))
>>>>  		return failed_creating(dentry);
>>>>  
>>>> -	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
>>>> +	if(!parent)
>>>> +		parent = debugfs_mount->mnt_root;
>>>> +	inode->i_mode = S_IFDIR | (d_inode(parent)->i_mode
>>>> +				   & (S_IRWXU | S_IRWXG));
>>>>  	inode->i_op = &simple_dir_inode_operations;
>>>>  	inode->i_fop = &simple_dir_operations;
>>>>  
>>>
>>> This looks ok, but is it going to change the permissions of existing
>>> stuff in ways that might breaks things, right?
>>
>> Right, but debugfs is usually mounted on /sys/kernel/debug with
>> permissions rwx to root owner. It can be changed after the mount, of course.
>> Unless this is done, the directory permissions for /sys/kernel/debug
>> will stop any descend regardless  of the subdirectory permissions.
>>
>>>
>>> Have you done a before/after comparison?
>>
>> I have tested this patch on my Linux 4.17.0rc2 kernel on s390.
>> That worked well, I have not tested other systems.
> 
> What do you mean by "worked well"?  What were the full tree differences
> between before and after?  You should be able to get this by using:
> 	tree -dp /sys/kernel/debug/
> and then doing a diff on the two files.
> 
> thanks,
> 
> greg k-h
> 

Ok, this is the tree output

Before the patch:
root@s8360047 ~]# tree -dp -L 1 /sys/kernel/debug/ 
/sys/kernel/debug/
├── [drwxr-xr-x]  bdi
├── [drwxr-xr-x]  block
├── [drwxr-xr-x]  dasd
├── [drwxr-xr-x]  device_component
├── [drwxr-xr-x]  extfrag
├── [drwxr-xr-x]  hid
├── [drwxr-xr-x]  kprobes
├── [drwxr-xr-x]  kvm
├── [drwxr-xr-x]  memblock
├── [drwxr-xr-x]  pm_qos
├── [drwxr-xr-x]  qdio
├── [drwxr-xr-x]  s390
├── [drwxr-xr-x]  s390dbf
└── [drwx------]  tracing

14 directories

After the patch:
[root@s8360047 ~]# tree -dp -L 1 /sys/kernel/debug/
sys/kernel/debug/
├── [drwx------]  bdi
├── [drwx------]  block
├── [drwx------]  dasd
├── [drwx------]  device_component
├── [drwx------]  extfrag
├── [drwx------]  hid
├── [drwx------]  kprobes
├── [drwx------]  kvm
├── [drwx------]  memblock
├── [drwx------]  pm_qos
├── [drwx------]  qdio
├── [drwx------]  s390
├── [drwx------]  s390dbf
└── [drwx------]  tracing

14 directories
[root@s8360047 ~]#

I attached the diff of the full tree before and after the patch.


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

--------------5395A79255F6AB5325A9A42F
Content-Type: text/x-patch;
 name="treefull.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="treefull.diff"

2,52c2,52
< ├── [drwxr-xr-x]  bdi
< │   ├── [drwxr-xr-x]  1:0
< │   ├── [drwxr-xr-x]  1:1
< │   ├── [drwxr-xr-x]  1:10
< │   ├── [drwxr-xr-x]  1:11
< │   ├── [drwxr-xr-x]  1:12
< │   ├── [drwxr-xr-x]  1:13
< │   ├── [drwxr-xr-x]  1:14
< │   ├── [drwxr-xr-x]  1:15
< │   ├── [drwxr-xr-x]  1:2
< │   ├── [drwxr-xr-x]  1:3
< │   ├── [drwxr-xr-x]  1:4
< │   ├── [drwxr-xr-x]  1:5
< │   ├── [drwxr-xr-x]  1:6
< │   ├── [drwxr-xr-x]  1:7
< │   ├── [drwxr-xr-x]  1:8
< │   ├── [drwxr-xr-x]  1:9
< │   └── [drwxr-xr-x]  94:0
< ├── [drwxr-xr-x]  block
< ├── [drwxr-xr-x]  dasd
< │   ├── [drwxr-xr-x]  0.0.e18a
< │   ├── [drwxr-xr-x]  dasda
< │   └── [drwxr-xr-x]  global
< ├── [drwxr-xr-x]  device_component
< ├── [drwxr-xr-x]  extfrag
< ├── [drwxr-xr-x]  hid
< ├── [drwxr-xr-x]  kprobes
< ├── [drwxr-xr-x]  kvm
< ├── [drwxr-xr-x]  memblock
< ├── [drwxr-xr-x]  pm_qos
< ├── [drwxr-xr-x]  qdio
< │   └── [drwxr-xr-x]  0.0.f5f2
< ├── [drwxr-xr-x]  s390
< │   └── [drwxr-xr-x]  stsi
< ├── [drwxr-xr-x]  s390dbf
< │   ├── [drwxr-xr-x]  0.0.e18a
< │   ├── [drwxr-xr-x]  cio_crw
< │   ├── [drwxr-xr-x]  cio_msg
< │   ├── [drwxr-xr-x]  cio_trace
< │   ├── [drwxr-xr-x]  dasd
< │   ├── [drwxr-xr-x]  kvm-trace
< │   ├── [drwxr-xr-x]  lgr
< │   ├── [drwxr-xr-x]  qdio_0.0.f5f2
< │   ├── [drwxr-xr-x]  qdio_error
< │   ├── [drwxr-xr-x]  qdio_setup
< │   ├── [drwxr-xr-x]  qeth_card_0.0.f5f0
< │   ├── [drwxr-xr-x]  qeth_control
< │   ├── [drwxr-xr-x]  qeth_msg
< │   ├── [drwxr-xr-x]  qeth_setup
< │   ├── [drwxr-xr-x]  vmcp
< │   └── [drwxr-xr-x]  vmur
---
> ├── [drwx------]  bdi
> │   ├── [drwx------]  1:0
> │   ├── [drwx------]  1:1
> │   ├── [drwx------]  1:10
> │   ├── [drwx------]  1:11
> │   ├── [drwx------]  1:12
> │   ├── [drwx------]  1:13
> │   ├── [drwx------]  1:14
> │   ├── [drwx------]  1:15
> │   ├── [drwx------]  1:2
> │   ├── [drwx------]  1:3
> │   ├── [drwx------]  1:4
> │   ├── [drwx------]  1:5
> │   ├── [drwx------]  1:6
> │   ├── [drwx------]  1:7
> │   ├── [drwx------]  1:8
> │   ├── [drwx------]  1:9
> │   └── [drwx------]  94:0
> ├── [drwx------]  block
> ├── [drwx------]  dasd
> │   ├── [drwx------]  0.0.e18a
> │   ├── [drwx------]  dasda
> │   └── [drwx------]  global
> ├── [drwx------]  device_component
> ├── [drwx------]  extfrag
> ├── [drwx------]  hid
> ├── [drwx------]  kprobes
> ├── [drwx------]  kvm
> ├── [drwx------]  memblock
> ├── [drwx------]  pm_qos
> ├── [drwx------]  qdio
> │   └── [drwx------]  0.0.f5f2
> ├── [drwx------]  s390
> │   └── [drwx------]  stsi
> ├── [drwx------]  s390dbf
> │   ├── [drwx------]  0.0.e18a
> │   ├── [drwx------]  cio_crw
> │   ├── [drwx------]  cio_msg
> │   ├── [drwx------]  cio_trace
> │   ├── [drwx------]  dasd
> │   ├── [drwx------]  kvm-trace
> │   ├── [drwx------]  lgr
> │   ├── [drwx------]  qdio_0.0.f5f2
> │   ├── [drwx------]  qdio_error
> │   ├── [drwx------]  qdio_setup
> │   ├── [drwx------]  qeth_card_0.0.f5f0
> │   ├── [drwx------]  qeth_control
> │   ├── [drwx------]  qeth_msg
> │   ├── [drwx------]  qeth_setup
> │   ├── [drwx------]  vmcp
> │   └── [drwx------]  vmur

--------------5395A79255F6AB5325A9A42F--
