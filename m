Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966902AbeBNEmK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 23:42:10 -0500
Received: from mail-by2nam03on0087.outbound.protection.outlook.com ([104.47.42.87]:36722
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966761AbeBNEmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 23:42:07 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [RFC PATCH 1/2] KVM: x86: Add a framework for supporting
 MSR-based features
To: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
 <1105042a-327b-9be9-c0be-5f07f7110852@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <79f0ea64-6634-4b1c-7ac6-82f6798c680b@amd.com>
Date: Tue, 13 Feb 2018 22:42:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1105042a-327b-9be9-c0be-5f07f7110852@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR08CA0086.namprd08.prod.outlook.com
 (2603:10b6:404:b6::24) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33c99569-8b65-4c3a-7ce2-08d573654cb7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:4dEjq0KxkhcUBX7+BYGxmQ9dTk2P+xl/xXhhUc62XJJXxqzTQ4RDnPJMqBPDU/DG1rKnH7U3EeADLBhOmZh/xqmzlxxHnIhIGozGbskI5l6xV0GM8+XcSlxNnfrCsii4RSPw9UM+Z9bzuRhGSLmUtHu5b8kOaAZlc9bqDVDeq9WzJH7z5914LsaS242Uxu+jRvijZtyLTy6BWuZkVPrQnH/rVLO0w9jcyQO2w60dncDFh23xph8FeR0MhfRFLP5a;25:fcshNHpW4m1YqVitGu5yljD7WDkEuI15P5PENBi62W30/pATNVprbRJBUtQlVQx72Kb9Hb5S/iUbfxuLv1srmbedGh9HmLXB6/kt9rq0N05/xPdjk3mQgyywe5a4S7bVfoFQJzi85J5qZkSplK02o/PMJBbv5I8M9qxHATCE2sCsGrJL0HiNOnSuKijt89a2zF2RsSjtEN5gQtARnzMUOEOQuMCL31IIaw0zJknJ/vFcvSfTD4nxK8QJz0hzdUOm+v1CRE8hK3lSMQ5qGd+EwzD7/VSV6x5pSqPlAAnVpxhiak6vC9JwOl/JhFT9+GUb7cYwNnwK1tSO+K+Ttu7VNA==;31:bPCGc8YV3Sftk9grJnPxjZ+LkRMIacwf690YClJ73u1un1bEZO2MBZeoo4vTOdfbY1cy+OimZM+K/8EPQRKO6/FMtrBLc12V/mxWYgOLzuZb30u2T4IAiuxjaBIayI4Q5nKJzJm9BfF4/TkXx8gRv3ne2uIviIy6AkfbzGFH9VEZmFeJkwn464jhD9TMsFXgwOLgmLj8tXkLPCwYgm/DSC4r6RXpQuuxGB8yITrLOdk=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:JdGJ0ICfVGhnN6J6/EwOWuXqw15eiGTPxS4Zi457Xz3cHqUrs5AgCFdcBKrcKrdPDECZUnZ012LqMkC/Vmv+OC66Ml3Mnnzq/NUrq75z6QujLN+Lxo+jiUr/ACu0T+IotppV7CmdfkXNFbT/2WmRDQic1VkFjuP3W+Y6iubDL7wwC0+V8Td389eE+fYQH1yRia14r+OB3MsI0vdEK38fSyQUZoYayUwg9V/xaAsUafgGn6MgvCFF0YeJcJkYAdJ2PSvrWqpOCI/nfWn2EZ0/oQUrcDkxeLLvJRfq242119hrE/ZfSGmdbHsjzRVIjchbQ1bfNMQTFgiWY4ma9OfwlW7hSezv817YoGEg/ds1frPKzlZV2wDA2PoUUtqgpPIf4CPlGcS1kT1G3QP8DMFwPJ/jmb8D5UxK+nruGHHrOSdO9RPGQHK8DBytsMA4WY3YnwDCro5GYgGcxoUOQr2JO9+BfwVRbPZhQiWjIg4UG+tnkhNKIWSr2Czoy4My3h5p;4:2zyoKyuv4mOXq0NraAg/BJiXYS4mUsZzrJTwRmdB8d0xhi4cBpBdawfsSq9ycLlYdB2gc5u0BYvBf1fb+2IhObRVoZBl3wX3P1r4mgQYIOr7F9Hsnq7lCNbszMn1EsFtBGL8az5bfbIcYgv13SwRcyOYsPwKrXIMYjlktN4heBE+9HHCMoLhPuCEa5iN8geQyjGb2pVp7v7QIz7/iFzJ0kqeYWugbMhtTrmcJCww0qvAeVaeKQvVxE5yRGE+vIrQ5VHfmrwasVaWgBmC4c2YIw==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1141B21E95EFE5F04C2E71F1ECF50@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(66066001)(52116002)(52146003)(65956001)(65806001)(229853002)(64126003)(8936002)(6666003)(68736007)(16576012)(81156014)(8676002)(81166006)(50466002)(47776003)(97736004)(53936002)(65826007)(2906002)(2950100002)(5660300001)(6246003)(83506002)(58126008)(36756003)(53546011)(76176011)(230700001)(72206003)(386003)(186003)(6486002)(31686004)(16526019)(31696002)(6116002)(3846002)(23676004)(2486003)(7736002)(54906003)(316002)(4326008)(105586002)(106356001)(3260700006)(478600001)(305945005)(26005)(25786009)(86362001)(77096007)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOjM4TS81VWwreThZcHdqYTMrZVp3OVdwUnA3?=
 =?utf-8?B?QVFrd3RnaHJzUC9LYk8vOGhxWEd6OUQvMXBMRExTRjk2U2hoa3U5MVlXN0dP?=
 =?utf-8?B?UWRxajlHekFVZkRQMjV6T0Y0cWdMdTU4MkU3ZksrOHJUcUZJZERnUUR3enRK?=
 =?utf-8?B?L0tFd1NLVkc0UStnUHhyWTJqdHpmZjJ1ME1iM2g1bkNaSXYzRnBsNDBUYkI3?=
 =?utf-8?B?WDFKVzZUUDlnemhQUmp1UUlLN2NKa1UvL0NQOUx6Vkp5U1Y4QWRDRFlKaW1X?=
 =?utf-8?B?S2FUNnN3Vldyd0J6MXFvdmZiRmxoMFhwWk96YUJ6TUpPazQwR0ZUUzNCSDI4?=
 =?utf-8?B?N2ZhZ3Z6TmN2OWoxMVpRRTF5TEQ1T2p0OVd5T1YwdXo4K1NTczB2Yitld2Rs?=
 =?utf-8?B?NWRIVE0zaHl4ODdiZU81ajd4OGpwc3lnYllkbmg0TGlsVHVtdEhEdWkzOC9w?=
 =?utf-8?B?dDNFdFJqeDhIam95bzlqaTRva3doV2JqcWNqK1FWOXlVRlphR3Q0eEhGYk85?=
 =?utf-8?B?aGVjQ1pJWlZaYmZEeEdZNk9RN1RMWmIrcHN1c0xVdWM3RWZRbm81N0d1L3Zw?=
 =?utf-8?B?MzJ0SEpEQzFJYVA1RkgzYndiTmhhZDZxdzAzSHpXbHI0WjloR2FvVTBzckVQ?=
 =?utf-8?B?aklIN0M3ZUVmZEw2NHVSRWFsZUdvN3c3WVFEU2krU05MUEcrZjJ1a29NRnBn?=
 =?utf-8?B?K285L3R1dUpOanlxMXVuVnJlQ255cDlFRUc3elBjQnpLTzV1blRyMExBTGtI?=
 =?utf-8?B?LzJDQXQzcEpMMytzSllXaUhFK3hIeW1HQ29BL1BSOU1EeWZVZDZIeXllZyti?=
 =?utf-8?B?RFN2UUIyMEhhSytkYkNydTcwNmc5d3MveUcyV2I1WlFzNlhwUXJSTE13Yk1i?=
 =?utf-8?B?dFBPZ09Ka0F6UUJtV2hCclhicytqTWRwaGJIWFNpSlJhOHJjeGZHTGROZXY0?=
 =?utf-8?B?b2wyZHFDNjIzcUxSZG9tYWJnTEo1bkUvZW5QT1RVY3IvalloaC9DRmNmeExV?=
 =?utf-8?B?d3o5dTJCY3BwQjVsS3RtblpHaDlDbmFLN3FxbUExMnlYWGpJWUs1MUhjWFlZ?=
 =?utf-8?B?RzV4T1UvM3JCUDQ0VG9YeFZteUo1V3pEaFM0RThXOVFpZEhtTTRuSXVJd0s2?=
 =?utf-8?B?L2hkS3VrbDJJSGI4M3I2cE1SZDRrek0yWGE0ZHJndFZCVHlzakg1cnJxQ0E0?=
 =?utf-8?B?endVRTA2U3hEanFwanYzQ0RKWFp3ZDZLNkNCZEFGVDZNUGh5eUY5MmI4VmNE?=
 =?utf-8?B?dVRmMWYreStUZU84UHFseWU5OWFYbHZjR2dtVkRaWEFEUEdJWHpWSExxcjFz?=
 =?utf-8?B?L3RHcWlGQUx2V281NGkydlFJWmErZERJb1lFcDNvQ2JSV2tuRmt1SVEwZDJM?=
 =?utf-8?B?WEFaRE5kVkpUSWdiTTJDMVBVT2thVmpjSmtMR1FwZEtRSFczV0JhZXdkc2NX?=
 =?utf-8?B?Smo1SU9iSkVHbVdhMk5WeU83Q1psNWdlVncwWkx0T1FTejVnZlNuS1YvZ0RY?=
 =?utf-8?B?WUdHaXdsV2ltTTJkODUzQ005cVpDQ2FEUGxVNk50d25FbzBsQlRScnBwTmFB?=
 =?utf-8?B?RmVQMnByRmxkZVN2amM0NVRlaVkxVk9hUmhDQS9RMkZNTVlHTjlJWjFVVXFY?=
 =?utf-8?B?NVJoUGd6NTVoeTVjM01lZkdJTGRsOVFRbjJLQlE3YjRCaG5WREo4QXRIbU4w?=
 =?utf-8?B?SlFDK2R5NWM2YW5iUzRSdWd1YVpHWmhhdnI0WTRMcTBVajViaGZZSjRNWS9N?=
 =?utf-8?B?aGxqS1hvSER0bGVodnBGZERHbldzZE55akF4N2hER0tQcGlMc1VPbk55MnBS?=
 =?utf-8?B?b1FpVnRTYVhOUWpKYytZNDJYZ2ZjL250RHJZVkVSQ28yQVlucmFHS1h5eWFQ?=
 =?utf-8?B?ZEtwbmJpUWhUbHlXZThpU2dJREpZdFIzeExUbGFZOS85SmZZV1cvS1RKRUFt?=
 =?utf-8?B?K1hXbEVRdlBnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:HBPrz8G1PNOnTapm+Zq0R5K2RlybxGENHAWKIyn/yblJ5RUW5hG1HjI1FHC0csULQ6EuD1J36sXlcEkYBGysHsslgNnj8us3D640KTI/JV2Ytq+ryuZRPNW5/5o+syeWgz8KkUIZOSw8SmRf6NcCQEQqzCVDZZMTsooqBHvVyVv1MsLU8n9ZwN8yA+R0H9KjzuXzlgnJWwR0pR4eso4qWOp3O7MkoPPF2KVMUjnylcIc/spkNa9jE70+ZohZSxECXDAKRqlJhgCfEYU+w/OVV+FIpWx8cT0Doz3Zm1N0hJf1uM0qjkFtiW79WYcJNl9hRhDv74oM4BbeXYyBPwF/YkRN4KWDavZPVFRwxMa/l+0=;5:oZ5Xsm6fVlr+JIV+n4L7BXxSH30WJsn1YHsvCEWOpL+c9PTROxwI4d5YgJESDy5S0shvSadODglEBWWtCk6N903w1GTVUZMxFrpPUM5sHb7OTmcO3bPcVc2OZVsDHFHpml1hpCZQA1LfmgwTjel7Y3Ca1YAhmNSRgkgGNVtLJu8=;24:MjPkXbyvNbRcBOAArrUq1UNBjzYYhnCPCvMBn7BuWjUDE1RoTWKxggKjdFETF7CPvyNQFA+n+qAKZj7URtsZV/SyCasODR06kfx9CZkEJZI=;7:AksgaNm91kh8+EnS3mMnkKPMRlXbKqd0lea+mbEnpqamGTCQhctlcmFp5LcPzxWoynqr0TwEqyPX/LIt0ejWTV9pk2oUFzibiwixezrFWwJceG6VpvZ5aFIJ7qRyLiNBdKTDDvtK5V2gFMAg8YzMuTfGQ/6yC8nU18OD+SGAGb3DUzZwLb0NFJ2xSzqsvh1B/57g5Q8yw1ohnUipXiC/Zx+jwBkNtA/TBDKdO6jj7nuDd7kaWguQUBQzzm/I7wNV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:o9KDIcPA3cNNDSLHWg8P9QY5NaHpt9+irSTRjzkOpUxWZa2JApvTfeIZy2zpbicllum/7LZ4vkUJxKnau2nibV3jvegbgPGDKw0btOvjC3nOsJVzn7YvPe5eSjFay3ISbNN0Uy/XMz8wCYn4hqBt6Bte3phyYHBVnhv7PU6J1s1rgcH91cGrkw0TWhE2kxN/dFxJVOe5ihpomB4P50zSiRT36fXudNN7R0AAfQVOHatLelc9RtR5Cti9QWmv5H3i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 04:42:04.8933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c99569-8b65-4c3a-7ce2-08d573654cb7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2018 10:25 AM, Paolo Bonzini wrote:
> On 08/02/2018 23:58, Tom Lendacky wrote:
>> +bool kvm_valid_msr_feature(u32 msr, u64 data)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < num_msr_based_features; i++) {
>> +		struct kvm_msr_based_features *m = msr_based_features + i;
>> +
>> +		if (msr != m->msr)
>> +			continue;
>> +
>> +		/* Make sure not trying to change unsupported bits */
>> +		return (data & ~m->mask) ? false : true;
>> +	}
>> +
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(kvm_valid_msr_feature);
>> +
> 
> This is probably unnecessary too (the allowed values are a bit more
> complicated for, you just guessed it, VMX capability MSRs) and you can
> just check bits other than LFENCE in svm_set_msr.

The whole routine or just the bit checking?  I can see still needing the
check to be sure the "feature" is present.

Thanks,
Tom

> 
> Paolo
> 
